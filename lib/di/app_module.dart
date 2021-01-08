import 'package:dio/dio.dart';
import 'package:flutter_sample/data/irepository.dart';
import 'package:flutter_sample/data/local/prefs/preferences.dart';
import 'package:flutter_sample/data/remote/api_impl/api_movie.dart';
import 'package:flutter_sample/data/repository_impl/default_repository.dart';
import 'package:flutter_sample/data/remote/iapi_movie.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_sample/ui/search/search_bloc.dart';
import 'package:flutter_sample/ui/show_all_movies/show_all_movie_bloc.dart';
import 'package:flutter_sample/ui/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 10000,
    receiveTimeout: 6000,
  ));
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<IApiMovie>(ApiMovie(locator<Dio>()));

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(PreferenceManager(sharedPreferences));

  locator.registerSingleton<IRepository>(
      DefaultRepository(locator<IApiMovie>(), locator<PreferenceManager>()));
  locator.registerSingleton<SplashBloc>(SplashBloc());
  locator.registerFactory<HomeBloc>(() => HomeBloc(locator<IRepository>()));
  locator.registerFactory(() => MovieDetailBloc(locator<IRepository>()));
  locator.registerFactory(() => ShowAllMovieBloc(locator<IRepository>()));
  locator.registerFactory(() => SearchBloc(locator<IRepository>()));
}
