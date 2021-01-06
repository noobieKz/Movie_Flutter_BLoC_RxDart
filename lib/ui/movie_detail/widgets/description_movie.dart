import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';

import '../../../constants.dart';

class DescriptionMovie extends StatefulWidget {
  final MovieDetailResponse movie;

  const DescriptionMovie({Key key, this.movie}) : super(key: key);

  @override
  _DescriptionMovieState createState() => _DescriptionMovieState(movie);
}

class _DescriptionMovieState extends State<DescriptionMovie> {
  final MovieDetailResponse movie;
  bool _isExpanded = false;

  _DescriptionMovieState(this.movie);

  @override
  Widget build(BuildContext context) {
    print("description rebuild");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2,
            horizontal: kDefaultPadding,
          ),
          child: Text(
            "Plot Summary",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GestureDetector(
            onTap: () {
              _expand();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: Text(
                    movie.overview,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  secondChild: Text(
                    movie.overview,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: kThemeAnimationDuration,
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _expand() {
    print("${'\n'.allMatches(movie.overview).length + 1}");
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
