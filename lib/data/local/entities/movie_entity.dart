import 'package:flutter_sample/data/local/app_database.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieEntity {
  int id;
  String name;
  String backdropPath;

  MovieEntity(this.id, this.name, this.backdropPath);

  MovieEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    backdropPath = json["backdropPath"];
  }

  MovieEntity.fromMovieDetailResponse(MovieDetailResponse movie) {
    id = movie.id;
    name = movie.title;
    backdropPath = movie.backdropPath;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data["backdropPath"] = this.backdropPath;
    return data;
  }
}
