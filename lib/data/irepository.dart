import 'local/category.dart';
import 'remote/response/genre_list_response.dart';
import 'remote/response/movie_list_response.dart';

abstract class IRepository {
  Future<MovieListResponse> getMovieByCategory(Category category, int page);

  Future<MovieListResponse> getMovieDiscover(int page);

  Future<GenreListResponse> getGenreList();
}
