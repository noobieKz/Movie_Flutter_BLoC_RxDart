import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/data/repository.dart';

class MovieDetailBloc extends BaseBloc {
  Repository _repository;

  MovieDetailBloc(this._repository);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
