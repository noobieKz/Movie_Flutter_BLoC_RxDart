import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc {
  IRepository _repository;
  BehaviorSubject<String> _keyQuerySubject = BehaviorSubject();

  //stream
  Stream<BaseState> get movieResults =>
      _keyQuerySubject.stream.switchMap((value) {
        print("Stream $value");
        return _getStateFromSearch(value);
      });

  SearchBloc(this._repository){
   print("search bloc crate");
  }

  void search(String query) {
    print(query.isEmpty);
    _keyQuerySubject.add(query);
  }

  Stream<BaseState> _getStateFromSearch(String query) async* {
    if (query.isEmpty) {
      yield StateLoaded<List<Movie>>([]);
      return;
    }
    yield StateLoading();
    try {
      MovieListResponse response = await _repository.searchMovies(query);
      if (response.error.isEmpty) {
        yield StateLoaded<List<Movie>>(response.results);
      } else {
        yield StateError(messageError);
      }
    } catch (e) {
      print("catch");
      yield StateError(messageError);
    }
  }

  @override
  void dispose() {
    _keyQuerySubject.close();
  }
}
