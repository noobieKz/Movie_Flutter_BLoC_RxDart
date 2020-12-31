import 'package:dio/dio.dart';
import 'package:flutter_sample/data/local/category.dart';

import 'response/genre_list_response.dart';
import 'response/movie_list_response.dart';

class ApiMovie {
  Dio _dio = Dio();
  static const String BASE_URL = 'https://api.themoviedb.org/3';
  static const String API_KEY = "8a1227b5735a7322c4a43a461953d4ff";

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
}
