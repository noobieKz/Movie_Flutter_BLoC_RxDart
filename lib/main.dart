import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repository.dart';
import 'ui/home/home_bloc.dart';
import 'ui/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Provider(
          create: (BuildContext context) {
            Repository repository = Repository();
            return HomeBloc(repository);
          },
          child: HomeScreen()),
    );
  }
}
