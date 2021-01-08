import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  SharedPreferences _sharedPreferences;
  static const _KEY_RECENT_SEARCH = "key_recent_search";

  PreferenceManager(this._sharedPreferences);

  Future saveRecentSearch(String query) async {
    return _sharedPreferences.setString(_KEY_RECENT_SEARCH, query);
  }

  String getRecentSearch() {
    return _sharedPreferences.getString(_KEY_RECENT_SEARCH) ?? "";
  }
}
