import 'package:dio/dio.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/iapi_movie.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/movie_gallery.dart';

import '../response/genre_list_response.dart';
import '../response/movie_list_response.dart';

class ApiMovie implements IApiMovie {
  Dio _dio;

  ApiMovie(this._dio);

  static const String BASE_URL = 'https://api.themoviedb.org/3';
  static const String API_KEY = "8a1227b5735a7322c4a43a461953d4ff";

  @override
  Future<MovieListResponse> getMovieByCategory(
      Category category, int page) async {
    final nowPlayingUrl = '$BASE_URL/movie/${category.keyQuery}';
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": page,
    };
    try {
      Response response =
          await _dio.get(nowPlayingUrl, queryParameters: params);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieListResponse.error("$error");
    }
  }

  @override
  Future<MovieListResponse> getDiscoverMovie(int page) async {
    final nowPlayingUrl = '$BASE_URL/discover/movie';
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": page,
    };
    try {
      Response response =
          await _dio.get(nowPlayingUrl, queryParameters: params);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieListResponse.error("$error");
    }
  }

  @override
  Future<GenreListResponse> getGenresList() async {
    final genresUrl = '$BASE_URL/genre/movie/list';
    var params = {
      "api_key": API_KEY,
    };
    try {
      Response response = await _dio.get(genresUrl, queryParameters: params);
      // await Future.delayed(Duration(seconds: 4));
      return GenreListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreListResponse.error("$error");
    }
  }

  @override
  Future<MovieListResponse> getMovieByGenreId(int genreId, int page) async {
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": page,
      "with_genres": genreId
    };
    String url = '$BASE_URL/discover/movie';
    try {
      Response response = await _dio.get(url, queryParameters: params);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieListResponse.error("$error");
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int movieId) async {
    var params = {
      'api_key': API_KEY,
    };
    try {
      String url = '$BASE_URL/movie/$movieId';
      Response response = await _dio.get(url, queryParameters: params);
      MovieDetailResponse movieDetailResponse =
          MovieDetailResponse.fromJson(response.data);
      print("success");
      return movieDetailResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.error(error.toString());
    }
  }

  @override
  Future<MovieGalleryResponse> getMovieGallery(int movieId) async {
    var params = {
      'api_key': API_KEY,
    };
    try {
      String url = "$BASE_URL/movie/$movieId/images";
      final response = await _dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return MovieGalleryResponse.fromJson(response.data);
      } else {
        return MovieGalleryResponse.error(response.statusMessage);
      }
    } catch (e) {
      return MovieGalleryResponse.error(e.toString());
      print(e.toString());
    }
  }

  @override
  Future<CastCrewResponse> getCastCrewMovie(int movieId) async {
    var params = {
      'api_key': API_KEY,
    };
    try {
      String url = "$BASE_URL/movie/$movieId/credits";
      final response = await _dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return CastCrewResponse.fromJson(response.data);
      } else {
        return CastCrewResponse.error(response.statusMessage);
      }
    } catch (e) {
      return CastCrewResponse.error(e.toString());
      print(e.toString());
    }
  }

  @override
  Future<MovieListResponse> searchMovies(String query, int page) async {
    var params = {
      'api_key': API_KEY,
      "query": query,
      "page": page
    };
    try {
      String url = "$BASE_URL/search/movie";
      final response = await _dio.get(url, queryParameters: params);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieListResponse.error("$error");
    }
  }
}
