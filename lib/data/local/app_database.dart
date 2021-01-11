import 'package:flutter_sample/data/local/movie_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const movieTable = "movie_table";
const movieColId = "id";
const movieColName = "name";
const movieColDescription = "description";
const movieColReleaseDate = "releaseDate";
const movieColTime = "time";
const movieColBackdropPath = "backdropPath";

abstract class AppDatabase {
  static AppDatabase build() {
    return _$AppDatabase();
  }

  Future<MovieDao> get movieDao;
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase._internal();

  static final _$AppDatabase _singleton = _$AppDatabase._internal();

  factory _$AppDatabase() {
    return _singleton;
  }

  static Database _database;

  Future<Database> get _instanceDatabase async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<Database> _initDatabase() async {
    String rootPath = await getDatabasesPath();
    String dbPath = join(rootPath, "Movie.db");
    var db = openDatabase(dbPath, version: 1, onCreate: _createDb);
    return db;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    const SQL_CREATE_TABLE_MOVIE =
        "CREATE TABLE $movieTable($movieColId INTEGER PRIMARY KEY, $movieColName TEXT, "
        "$movieColDescription TEXT, $movieColReleaseDate TEXT, "
        "$movieColTime TEXT, $movieColBackdropPath TEXT)";

    await db.execute(SQL_CREATE_TABLE_MOVIE);
  }

  @override
  Future<MovieDao> get movieDao async {
    var db = await _instanceDatabase;
    return $MovieDaoImpl(db);
  }
}
