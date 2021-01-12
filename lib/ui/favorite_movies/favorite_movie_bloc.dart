import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/local/entities/movie_entity.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteMovieBloc extends BaseBloc {
  IRepository _repository;

  FavoriteMovieBloc(this._repository);

  BehaviorSubject<BaseState> _favMovieSubject = BehaviorSubject();

  //stream
  Stream<BaseState> get favMovieStream => _favMovieSubject.stream;

  Future getFavoriteMovies() async {
    _favMovieSubject.add(StateLoading());
    var result = await _repository.getFavoriteMovies();
    _favMovieSubject.add(StateLoaded<List<MovieEntity>>(result));
  }

  @override
  void dispose() {
    _favMovieSubject.close();
  }
}
