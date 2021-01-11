import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/local/entities/movie_entity.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BaseBloc {
  IRepository _repository;

  BehaviorSubject<BaseState> _movieDetailSubject = BehaviorSubject<BaseState>();

  BehaviorSubject<BaseState> _movieGallerySubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<BaseState> _movieCastCrewSubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<bool> _movieIsFavSubject = BehaviorSubject();

  //stream
  Stream<BaseState> get movieDetailStream => _movieDetailSubject.stream;

  Stream<BaseState> get movieGalleryStream => _movieGallerySubject.stream;

  Stream<BaseState> get castCrewStream => _movieCastCrewSubject.stream;

  Stream<bool> get isFavStream => _movieIsFavSubject.stream;

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

  Future getMovieGallery(int movieId) async {
    try {
      _movieGallerySubject.add(StateLoading());
      MovieGalleryResponse response =
          await _repository.getMovieGallery(movieId);
      if (response.error.isEmpty) {
        _movieGallerySubject.add(StateLoaded<MovieGalleryResponse>(response));
      } else {
        print(response.error);
        _movieGallerySubject.add(StateError(messageError));
      }
    } catch (e) {
      print(e.toString());
      _movieGallerySubject.add(StateError(messageError));
    }
  }

  Future getCastAndCrew(int movieId) async {
    try {
      _movieCastCrewSubject.add(StateLoading());
      CastCrewResponse response = await _repository.getCastCrewMovie(movieId);
      if (response.error.isEmpty) {
        _movieCastCrewSubject.add(StateLoaded<CastCrewResponse>(response));
      } else {
        print(response.error);
        _movieCastCrewSubject.add(StateError(messageError));
      }
    } catch (e) {
      print(e.toString());
      _movieCastCrewSubject.add(StateError(messageError));
    }
  }

  void setMovieToRated(int id) {
    _repository.saveListIdRated(id);
  }

  bool isMovieRated(int id) {
    return _repository.getListIdRated().contains(id.toString());
  }

  Future<bool> addToFavorite(MovieEntity movieEntity) async {
    bool result = await _repository.addToFavorite(movieEntity);
    if (result) _movieIsFavSubject.add(true);
    return result;
  }

  Future<bool> removeFromFavorite(MovieEntity movieEntity) async {
    bool result = await _repository.removeFromFavorite(movieEntity);
    if (result) _movieIsFavSubject.add(false);
    return result;
  }

  Future<void> isFavorite(int movieId) async {
    bool isFav = await _repository.isFavorite(movieId);
    _movieIsFavSubject.add(isFav);
  }

  @override
  void dispose() {
    _movieCastCrewSubject.close();
    _movieDetailSubject.close();
    _movieGallerySubject.close();
    _movieIsFavSubject.close();
  }
}
