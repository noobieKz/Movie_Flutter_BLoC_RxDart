import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/data/repository.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:rxdart/rxdart.dart';

class ShowAllMovieBloc extends BaseBloc {
  static const FIRST_PAGE = 1;
  Repository _repository;

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  List<Movie> _movieCached = [];
  int _currentPage = 2; //start load more at 2
  bool hasMoreData = true;

  ShowAllMovieBloc(this._repository);

  Future getMovieByCategoryFirstPage(Category category) async {
    _movieByCategorySubject.add(StateLoading());
    var response = await _repository.getMovieByCategory(category, FIRST_PAGE);
    List<Movie> newList = response.results;
    if (response.error.isEmpty) {
      _movieCached.addAll(newList);
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(_movieCached));
    } else {
      _movieByCategorySubject
          .add(StateError("Oops! Some error occurred ( ͡° ͜ʖ ͡°)"));
    }
  }

  Future requestMore(Category category) async {
    try {
      if (!hasMoreData) return;
      var response =
          await _repository.getMovieByCategory(category, _currentPage);
      if (_currentPage >= response.totalPages) {
        hasMoreData = false;
      }
      List<Movie> newList = response.results;
      if (response.error.isEmpty) {
        _currentPage++;
        _movieCached.addAll(newList);
      }
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(_movieCached));
      print(_currentPage);
    } catch (e) {}
  }

  @override
  void dispose() {
    _movieByCategorySubject.close();
  }
}
