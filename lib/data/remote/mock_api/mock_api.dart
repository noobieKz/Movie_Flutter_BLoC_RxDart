import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/iapi_movie.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';

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
}
