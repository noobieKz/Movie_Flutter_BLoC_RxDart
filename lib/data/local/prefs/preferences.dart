import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  SharedPreferences _sharedPreferences;
  static const _KEY_RECENT_SEARCH = "key_recent_search";
  static const _KEY_MOVIE_RATED = "key_movie_rated";

  PreferenceManager(this._sharedPreferences);

  Future saveRecentSearch(String query) async {
    return _sharedPreferences.setString(_KEY_RECENT_SEARCH, query);
  }

  String getRecentSearch() {
    return _sharedPreferences.getString(_KEY_RECENT_SEARCH) ?? "";
  }

  Future saveMovieIdRated(String listId) async {
    return _sharedPreferences.setString(_KEY_MOVIE_RATED, listId);
  }

  String getListIdRated() {
    return _sharedPreferences.getString(_KEY_MOVIE_RATED) ?? "";
  }
}
