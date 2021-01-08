import 'package:flutter_sample/data/remote/response/movie_list_response.dart';

class BaseState {}

class StateLoading extends BaseState {}

class StateLoaded<T> extends BaseState {
  final T value;

  StateLoaded(this.value);
}

class StateError extends BaseState {
  final String msgError;

  StateError(this.msgError);
}
