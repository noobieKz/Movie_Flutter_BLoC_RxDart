import 'package:flutter_sample/data/remote/api_movie.dart';
import 'package:flutter_sample/data/repository.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_sample/ui/show_all_movies/show_all_movie_bloc.dart';
import 'package:flutter_sample/ui/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ApiMovie>(ApiMovie());
  locator.registerSingleton<Repository>(Repository());
  locator.registerSingleton<SplashBloc>(SplashBloc());
  locator.registerFactory<HomeBloc>(() => HomeBloc(locator<Repository>()));
  locator.registerFactory(() => MovieDetailBloc(locator<Repository>()));
  locator.registerFactory(() => ShowAllMovieBloc(locator<Repository>()));
}
