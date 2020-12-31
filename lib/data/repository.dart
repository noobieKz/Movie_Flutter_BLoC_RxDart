import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/api_movie.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';

class Repository {
  ApiMovie _apiMovie = ApiMovie();

  Future<MovieListResponse> getMovieByCategory(
      Category category, int page) async {
    return _apiMovie.getMovieByCategory(category, page);
  }

  Future<MovieListResponse> getMovieDiscover(int page) async {
    return _apiMovie.getDiscoverMovie(page);
  }

  Future<GenreListResponse> getGenreList() async {
    return _apiMovie.getGenresList();
  }
}
