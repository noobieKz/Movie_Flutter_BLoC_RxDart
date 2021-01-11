import 'package:flutter_sample/data/local/entities/movie_entity.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';

import '../constants.dart';
import 'remote/response/genre_list_response.dart';
import 'remote/response/movie_detail_response.dart';
import 'remote/response/movie_list_response.dart';

abstract class IRepository {
  Future<MovieListResponse> getMovieByCategory(Category category, int page);

  Future<MovieListResponse> getMovieDiscover(int page);

  Future<MovieListResponse> getMovieByGenreId(int genreId, int page);

  Future<GenreListResponse> getGenreList();

  Future<MovieDetailResponse> getMovieDetail(int movieId);

  Future<MovieGalleryResponse> getMovieGallery(int movieId);

  Future<CastCrewResponse> getCastCrewMovie(int movieId);

  Future<MovieListResponse> searchMovies(String query, int page);

  List<String> getListRecentSearch();

  Future<List<String>> saveRecentSearch(String query);

  String getListIdRated();

  String saveListIdRated(int id);

  Future<bool> addToFavorite(MovieEntity movieEntity);

  Future<bool> removeFromFavorite(MovieEntity movieEntity);


  Future<List<MovieEntity>> getFavoriteMovies();

  Future<bool> isFavorite(int movieId);
}
