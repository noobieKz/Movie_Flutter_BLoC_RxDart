import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  IRepository _repository;
  static const _FIRST_PAGE = 1;

  BehaviorSubject<Category> _categorySubject =
      BehaviorSubject.seeded(listCategory[0]);

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<BaseState> _movieDiscoverSubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<BaseState> _genresSubject = BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  Stream<BaseState> get moviesDiscover => _movieDiscoverSubject.stream;

  Stream<BaseState> get genresListStream => _genresSubject.stream;

  Category get currentCategory => _categorySubject.stream.value;

  HomeBloc(this._repository) {
    print("new homebloc create");
    _listenCategoryChange();
  }

  Future _requestMovieByCategory(Category category, int page) async {
    _movieByCategorySubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _repository.getMovieByCategory(category, page);
    if (response.error.isEmpty)
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(response.results));
    else {
      _movieByCategorySubject
          .add(StateError("Oops! Some error occurred ( ͡° ͜ʖ ͡°)"));
    }
  }

  void _listenCategoryChange() {
    _categorySubject.listen((category) {
      _requestMovieByCategory(category, _FIRST_PAGE);
    });
  }

  Future getDiscoverMovies(int page) async {
    _movieDiscoverSubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _repository.getMovieDiscover(page);
    if (response.error.isEmpty)
      _movieDiscoverSubject.add(StateLoaded<List<Movie>>(response.results));
    else {
      _movieDiscoverSubject.add(StateError(messageError));
    }
  }

  Future getGenreList() async {
    _genresSubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _repository.getGenreList();
    if (response.error.isEmpty)
      _genresSubject.add(StateLoaded<List<Genre>>(response.genres));
    else {
      _genresSubject.add(StateError(messageError));
    }
  }

  void changeCategory(Category category) {
    _categorySubject.add(category);
  }

  @override
  void dispose() {
    _categorySubject.close();
    _movieByCategorySubject.close();
    _movieDiscoverSubject.close();
    _genresSubject.close();
  }
}
