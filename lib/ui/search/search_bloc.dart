import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:flutter_sample/utils/exts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class SearchBloc extends BaseBloc {
  IRepository _repository;

  SearchBloc(this._repository) {
    print("search bloc crate");
    _movieLoadMoreSubject.listen((state) {
      if (state is StateLoaded<List<Movie>>) {
        print("LoadMore ${state.value.length}");
      }
    });
  }

  BehaviorSubject<bool> _loadMoreSubject = BehaviorSubject.seeded(false);

  //local logic
  BehaviorSubject<Tuple2<String, int>> _keyQuerySubject = BehaviorSubject();

  BehaviorSubject<List<String>> _recentSearch = BehaviorSubject<List<String>>();

  bool hasMoreData = true;
  int _currentPageLoadMore = 2;
  List<Movie> _movieCached = [];
  static const FIRST_PAGE = 1;

  BehaviorSubject<BaseState> _movieLoadMoreSubject =
      BehaviorSubject.seeded(StateLoaded<List<Movie>>([]));

  //stream
  Stream<BaseState> get movieResults =>
      _keyQuerySubject.stream.switchMap((value) {
        return (value.item2 == FIRST_PAGE)
            ? _firstRequestState(value.item1)
            : _requestMoreState();
      });

  Stream<List<String>> get recentSearch => _recentSearch.stream;

  Stream<bool> get loadMore => _loadMoreSubject.stream;

  void _onNewQuery() {
    _movieCached.clear();
    hasMoreData = true;
    _currentPageLoadMore = 2;
  }

  void getRecentSearch() {
    loggerTag("SearchBloc", "getListRecent");
    _recentSearch.add(_repository.getListRecentSearch());
  }

  void search(String query) {
    if (_keyQuerySubject.value != null &&
        query != _keyQuerySubject.value.item1) {
      _onNewQuery();
    }
    _keyQuerySubject.add(Tuple2(query, FIRST_PAGE));
    Future.delayed(Duration(milliseconds: 300))
        .then((value) => _saveRecentSearch(query));
  }

  void _saveRecentSearch(String query) {
    if (query.isNotEmpty && !_repository.getListRecentSearch().contains(query))
      _repository.saveRecentSearch(query).then((value) {
        _recentSearch.add(value);
      });
  }

  void searchNextPage() {
    _keyQuerySubject
        .add(Tuple2(_keyQuerySubject.value.item1, _currentPageLoadMore));
  }

  Stream<BaseState> _firstRequestState(String query) async* {
    if (query.isEmpty) {
      yield StateLoaded<List<Movie>>([]);
      return;
    }
    yield StateLoading();
    try {
      MovieListResponse response =
          await _repository.searchMovies(query, FIRST_PAGE);
      if (response.error.isEmpty) {
        if (_currentPageLoadMore >= response.totalPages) {
          hasMoreData = false;
        }
        _movieCached.addAll(response.results);
        if (hasMoreData) _movieCached.add(null);
        yield StateLoaded<List<Movie>>(_movieCached);
      } else {
        yield StateError(messageError);
      }
    } catch (e) {
      print("catch");
      yield StateError(messageError);
    }
  }

  Stream<BaseState> _requestMoreState() async* {
    try {
      if (!hasMoreData) return;
      MovieListResponse response = await _repository.searchMovies(
          _keyQuerySubject.value.item1, _currentPageLoadMore);
      if (_currentPageLoadMore >= response.totalPages) {
        hasMoreData = false;
      }
      List<Movie> newList = response.results;
      if (response.error.isEmpty) {
        _movieCached.remove(null);
        _currentPageLoadMore++;
        _movieCached.addAll(newList);
        if (hasMoreData) _movieCached.add(null);
      } else {
        if (_movieCached.contains(null)) _movieCached.remove(null);
      }
      yield (StateLoaded<List<Movie>>(_movieCached));
    } catch (e) {
      if (_movieCached.contains(null)) _movieCached.remove(null);
      yield (StateLoaded<List<Movie>>(_movieCached));
      print("wtfffff" + e.toString());
    }
  }

  @override
  void dispose() {
    _keyQuerySubject.close();
    _loadMoreSubject.close();
    _recentSearch.close();
  }
}
