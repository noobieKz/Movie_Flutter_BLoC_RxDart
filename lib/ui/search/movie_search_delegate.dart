import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/iapi_movie.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/search/search_screen.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<String> all = ["a", "b", "c", "d", "e", "f"];
  List<String> recent = ["a", "b"];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: bgColor,
      primaryIconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(elevation: 1),
      textTheme: Theme.of(context).textTheme.copyWith(
          headline6: TextStyle(
              //search-bar use text-editing = headline6
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400)),
      hintColor: Colors.white70,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  String get searchFieldLabel => "Search here...";

  @override
  TextStyle get searchFieldStyle => TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white54);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchScreen(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty ? recent : all;
    return Container(
      color: bgColor,
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.location_city),
          title: Text(suggestions[index]),
        ),
        itemCount: suggestions.length,
      ),
    );
  }
}
