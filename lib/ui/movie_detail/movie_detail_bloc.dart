import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BaseBloc {
  IRepository _repository;

  BehaviorSubject<BaseState> _movieDetailSubject = BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get movieDetailStream => _movieDetailSubject.stream;

  MovieDetailBloc(this._repository);

  Future getMovieDetail(int movieId) async {
    print(movieId);
    try {
      _movieDetailSubject.add(StateLoading());
      MovieDetailResponse response = await _repository.getMovieDetail(movieId);
      if (response.error.isEmpty) {
        _movieDetailSubject.add(StateLoaded<MovieDetailResponse>(response));
      } else {
        print(response.error);
        _movieDetailSubject.add(StateError(messageError));
      }
    } catch (e) {
      print(e.toString());
      _movieDetailSubject.add(StateError(messageError));
    }
  }

  @override
  void dispose() {
    _movieDetailSubject.close();
  }
}
