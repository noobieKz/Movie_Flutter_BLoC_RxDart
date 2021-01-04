import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';

abstract class IApiMovie {
  Future<MovieListResponse> getMovieByCategory(Category category, int page);

  Future<MovieListResponse> getDiscoverMovie(int page);

  Future<GenreListResponse> getGenresList();
}
