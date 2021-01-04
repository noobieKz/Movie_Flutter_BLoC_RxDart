import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';

import 'ui/home/home_bloc.dart';
import 'ui/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConfig.ROUTE_SPLASH,
      onGenerateRoute: (settings) => RouteConfig.generateRoute(settings),
    );
  }
}
