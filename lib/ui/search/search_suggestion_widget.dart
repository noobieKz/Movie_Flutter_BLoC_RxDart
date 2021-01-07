import 'package:flutter/material.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class SearchSuggestionWidget extends StatelessWidget {
  List<String> all = ["batman", "comic", "fight", "action", "kungfu", "honor"];
  List<String> recent = ["batman", "comic", "fight", "action", "kungfu", "honor"];
  final String query;
  final Function(String) onSuggestionSelected;

  SearchSuggestionWidget({Key key, this.query, this.onSuggestionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestions = query.isEmpty ? recent : all;
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            onSuggestionSelected(suggestions[index]);
          },
          leading: Icon(
            Icons.search,
            color: Colors.white,
          ),
          title: Text(
            suggestions[index],
            style: TextStyle(color: Colors.white),
          ),
        ),
        itemCount: suggestions.length,
      ),
    );
  }
}
