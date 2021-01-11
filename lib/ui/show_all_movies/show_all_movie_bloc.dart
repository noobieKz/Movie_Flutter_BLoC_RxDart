
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:flutter_sample/vo/type_show_all.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants.dart';

class ShowAllMovieBloc extends BaseBloc {
  static const FIRST_PAGE = 1;
  IRepository _repository;

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  List<Movie> _movieCached = [];
  int _currentPage = 2; //start load more at 2
  bool hasMoreData = true;

  ShowAllMovieBloc(this._repository);

  Future getMovieByTypeShowFirstPage(TypeShowAll typeShowAll) async {
    try {
      _movieByCategorySubject.add(StateLoading());
      MovieListResponse response =
          await _getResponseByType(typeShowAll, FIRST_PAGE);
      if (_currentPage >= response.totalPages) {
        hasMoreData = false;
      }
      List<Movie> newList = response.results;
      if (response.error.isEmpty) {
        _movieCached.addAll(newList);
        if (hasMoreData) _movieCached.add(null);
        _movieByCategorySubject.add(StateLoaded<List<Movie>>(_movieCached));
      } else {
        _movieByCategorySubject.add(StateError(messageError));
      }
    } catch (e) {
      _movieByCategorySubject.add(StateError(messageError));
      print(e.toString());
    }
  }

  Future<MovieListResponse> _getResponseByType(
      TypeShowAll typeShowAll, int page) {
    if (typeShowAll.type == Type.CATEGORY) {
      Category category = typeShowAll.data;
      return _repository.getMovieByCategory(category, page);
    } else if (typeShowAll.type == Type.DISCOVER) {
      return _repository.getMovieDiscover(page);
    } else if (typeShowAll.type == Type.GENRE) {
      Genre genre = typeShowAll.data;
      return _repository.getMovieByGenreId(genre.id, page);
    } else {
      throw Exception("Unknown Exception");
    }
  }

  Future requestMore(TypeShowAll typeShowAll) async {
    try {
      if (!hasMoreData) return;
      MovieListResponse response =
          await _getResponseByType(typeShowAll, _currentPage);
      if (_currentPage >= response.totalPages) {
        hasMoreData = false;
      }
      List<Movie> newList = response.results;
      if (response.error.isEmpty) {
        _movieCached.remove(null);
        _currentPage++;
        _movieCached.addAll(newList);
        if (hasMoreData) _movieCached.add(null);
      } else {
        if (_movieCached.contains(null)) _movieCached.remove(null);
      }
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(_movieCached));
    } catch (e) {
      if (_movieCached.contains(null)) _movieCached.remove(null);
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(_movieCached));
      print("wtfffff" + e.toString());
    }
  }

  @override
  void dispose() {
    _movieByCategorySubject.close();
  }
}
