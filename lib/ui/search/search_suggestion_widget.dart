import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/search/search_bloc.dart';
import 'package:flutter_sample/utils/exts.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class SearchSuggestionWidget extends StatelessWidget {
  final String query;
  final Function(String) onSuggestionSelected;

  SearchSuggestionWidget({Key key, this.query, this.onSuggestionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    loggerTag("SearchBloc", query);
    context.watch<SearchBloc>().getRecentSearch();
    return StreamBuilder<List<String>>(
      stream: context.watch<SearchBloc>().recentSearch,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          final List<String> suggestions = _suggestionsList(snapshot.data);
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
        } else {
          return Container();
        }
      },
    );
  }

  List<String> _suggestionsList(List<String> all) {
    final List<String> suggestions = [];
    if (query.isEmpty) {
      return all;
    }
    for (String item in all) {
      if (item.contains(query)) {
        suggestions.add(item);
      }
    }
    return suggestions;
  }
}
