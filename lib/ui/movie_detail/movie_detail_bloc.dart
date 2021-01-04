import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/data/irepository.dart';

class MovieDetailBloc extends BaseBloc {
  IRepository _repository;

  MovieDetailBloc(this._repository);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
