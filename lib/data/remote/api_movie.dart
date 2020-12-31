import 'package:dio/dio.dart';

import 'response/movie_list_response.dart';

class ApiMovie {
  Dio _dio = Dio();
  static const String BASE_URL = 'https://api.themoviedb.org/3';
  static const String API_KEY = "8a1227b5735a7322c4a43a461953d4ff";

  Future<MovieListResponse> getPlayingMovies() async {
    final nowPlayingUrl = '$BASE_URL/movie/now_playing';
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": 1,
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
}
