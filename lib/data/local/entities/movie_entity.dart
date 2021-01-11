import 'package:flutter_sample/data/local/app_database.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieEntity {
  int id;
  String name;
  String description;
  String releaseDate;
  String time;
  String backdropPath;

  MovieEntity(this.id, this.name, this.description, this.releaseDate, this.time,
      this.backdropPath);

  MovieEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json["description"];
    releaseDate = json["releaseDate"];
    time = json["time"];
    backdropPath = json["backdropPath"];
  }

  MovieEntity.fromMovieDetailResponse(MovieDetailResponse movie) {
    id = movie.id;
    name = movie.title;
    description = movie.overview;
    releaseDate = movie.releaseDate;
    time = convertTimeToString(movie.runtime);
    backdropPath = movie.backdropPath;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data["description"] = this.description;
    data["releaseDate"] = this.releaseDate;
    data["time"] = this.time;
    data["backdropPath"] = this.backdropPath;
    return data;
  }
}
