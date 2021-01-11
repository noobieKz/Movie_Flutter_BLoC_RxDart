import 'package:flutter_sample/data/local/app_database.dart';
import 'package:flutter_sample/data/local/entities/movie_entity.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/utils/exts.dart';
import 'package:sqflite/sqflite.dart';

abstract class MovieDao {
  Future<bool> addToFavorite(MovieEntity movie);

  Future<bool> removeFromFavorite(MovieEntity movie);

  Future<List<MovieEntity>> getListFavorite();

  Future<bool> isFavorite(int movieId);
}

class $MovieDaoImpl extends MovieDao {
  final Database _database;

  $MovieDaoImpl(this._database);

  @override
  Future<bool> addToFavorite(MovieEntity movie) async {
    try {
      await _database.insert(movieTable, movie.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<MovieEntity>> getListFavorite() async {
    var map = await _database.query(movieTable);
    return map.map((e) => MovieEntity.fromJson(e)).toList();
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    var map = await _database
        .query(movieTable, where: "id = ?", whereArgs: [movieId]);
    var list = map.map((e) => MovieEntity.fromJson(e)).toList();
    return list.isNotEmpty;
  }

  @override
  Future<bool> removeFromFavorite(MovieEntity movie) async {
    try {
      int result = await _database
          .delete(movieTable, where: "id = ?", whereArgs: [movie.id]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
