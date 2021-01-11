import 'package:flutter_sample/data/remote/iapi_movie.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/data/remote/response/rate_movie_response.dart';

import '../../../constants.dart';

class MockApi implements IApiMovie {
  @override
  Future<MovieListResponse> getDiscoverMovie(int page) {
    // TODO: implement getDiscoverMovie
    throw UnimplementedError();
  }

  @override
  Future<GenreListResponse> getGenresList() {
    // TODO: implement getGenresList
    throw UnimplementedError();
  }

  @override
  Future<MovieListResponse> getMovieByCategory(Category category, int page) {
    // TODO: implement getMovieByCategory
    throw UnimplementedError();
  }

  @override
  Future<MovieListResponse> getMovieByGenreId(int genreId, int page) {
    // TODO: implement getMovieByGenreId
    throw UnimplementedError();
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int movieId) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<MovieGalleryResponse> getMovieGallery(int movieId) {
    // TODO: implement getMovieGallery
    throw UnimplementedError();
  }

  @override
  Future<CastCrewResponse> getCastCrewMovie(int movieId) {
    // TODO: implement getCastCrewMovie
    throw UnimplementedError();
  }

  @override
  Future<MovieListResponse> searchMovies(String query, int page) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }

  @override
  Future<RateMovieResponse> rateMovie(int value) {
    // TODO: implement rateMovie
    throw UnimplementedError();
  }
}
