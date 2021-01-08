import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/search/search_result_widget.dart';
import 'package:flutter_sample/ui/search/search_suggestion_widget.dart';
import 'package:provider/provider.dart';
import 'search_bloc.dart';

enum _SearchBody { SUGGESTIONS, RESULT }

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: locator<SearchBloc>(),
      child: SearchWidget(),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchBloc _bloc;
  TextEditingController _textEditingController;
  FocusNode _focusNode;

  _SearchBody get _currentBody => _currentBodyNotifier.value;

  set _currentBody(_SearchBody value) {
    _currentBodyNotifier.value = value;
  }

  final ValueNotifier<_SearchBody> _currentBodyNotifier =
      ValueNotifier<_SearchBody>(_SearchBody.SUGGESTIONS);

  @override
  void initState() {
    _bloc = context.read<SearchBloc>();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _currentBodyNotifier.addListener(_rebuild);
    _textEditingController.addListener(_rebuild);
    _bloc = context.read<SearchBloc>();
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  void _rebuild() {
    setState(() {});
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _currentBody != _SearchBody.SUGGESTIONS) {
      showSuggestions();
    }
  }

  void _showEmptyIfClear() {
    _textEditingController.text = "";
    if (!_focusNode.hasFocus && _currentBody != _SearchBody.SUGGESTIONS) {
      _bloc.search("");
    }
  }

  void showResults(String query, bool selectFromSuggestion) {
    if (selectFromSuggestion) _textEditingController.text = query;
    _focusNode.unfocus();
    _currentBody = _SearchBody.RESULT;
    _bloc.search(query);
  }

  void showSuggestions() {
    _focusNode.requestFocus();
    _currentBody = _SearchBody.SUGGESTIONS;
  }

  @override
  Widget build(BuildContext context) {
    print("search build");
    Widget body;
    String suggestionQuery = _textEditingController.text;
    switch (_currentBody) {
      case _SearchBody.SUGGESTIONS:
        body = SearchSuggestionWidget(
          query: suggestionQuery,
          onSuggestionSelected: (query) {
            showResults(query, true);
          },
        );
        break;
      case _SearchBody.RESULT:
        body = SearchResultWidget(
          onLoadMore: () => _bloc.searchNextPage(),
        );
        break;
    }
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: bgColor,
        title: TextField(
          style: TextStyle(color: Colors.white),
          onSubmitted: (newValue) {
            showResults(newValue, false);
          },
          focusNode: _focusNode,
          controller: _textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search here...",
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _showEmptyIfClear();
            },
            color: Colors.white,
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(microseconds: 300),
        child: body,
      ),
    );
  }
}
