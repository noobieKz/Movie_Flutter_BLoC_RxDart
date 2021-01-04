import 'package:flutter_sample/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc extends BaseBloc {
  BehaviorSubject<SplashState> _splashSubject =
      BehaviorSubject.seeded(SplashState.LOADING);

  //stream
  Stream<SplashState> get splashStream => _splashSubject.stream;

  Future fakeLoading() async {
    _splashSubject.add(SplashState.LOADING);
    await Future.delayed(Duration(seconds: 2));
    _splashSubject.add(SplashState.DONE);
  }

  @override
  void dispose() {
    print("splash bloc dispose");
    _splashSubject.close();
  }
}

enum SplashState { LOADING, DONE }
