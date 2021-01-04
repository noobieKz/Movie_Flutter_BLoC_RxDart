import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/home/home_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(movieId);
    return Container();
  }
}
