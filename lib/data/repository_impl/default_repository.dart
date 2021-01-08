import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/local/prefs/preferences.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/utils/exts.dart';

import '../remote/iapi_movie.dart';

class DefaultRepository implements IRepository {
  IApiMovie _apiMovie;
  PreferenceManager _preferenceManager;

  DefaultRepository(this._apiMovie, this._preferenceManager);

  //local logic
  String _recentSearchCached = "";

  @override
  Future<MovieListResponse> getMovieByCategory(
      Category category, int page) async {
    return _apiMovie.getMovieByCategory(category, page);
  }

  @override
  Future<MovieListResponse> getMovieDiscover(int page) async {
    return _apiMovie.getDiscoverMovie(page);
  }

  @override
  Future<GenreListResponse> getGenreList() async {
    return _apiMovie.getGenresList();
  }

  @override
  Future<MovieListResponse> getMovieByGenreId(int genreId, int page) {
    return _apiMovie.getMovieByGenreId(genreId, page);
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int movieId) {
    return _apiMovie.getMovieDetail(movieId);
  }

  @override
  Future<MovieGalleryResponse> getMovieGallery(int movieId) {
    return _apiMovie.getMovieGallery(movieId);
  }

  @override
  Future<CastCrewResponse> getCastCrewMovie(int movieId) {
    return _apiMovie.getCastCrewMovie(movieId);
  }

  @override
  Future<MovieListResponse> searchMovies(String query, int page) {
    return _apiMovie.searchMovies(query, page);
  }

  @override
  List<String> getListRecentSearch() {
    loggerTag("Repository", _recentSearchCached);
    _recentSearchCached = _preferenceManager.getRecentSearch();
    return _recentSearchCached.isEmpty ? [] : _recentSearchCached.split("-");
  }

  @override
  Future<List<String>> saveRecentSearch(String query) {
    String newRecent = _recentSearchCached.isEmpty
        ? "$query"
        : _recentSearchCached + "-$query";
    loggerTag("Repository", newRecent);
    return _preferenceManager
        .saveRecentSearch(newRecent)
        .then((value) => newRecent.split("-"));
  }
}
