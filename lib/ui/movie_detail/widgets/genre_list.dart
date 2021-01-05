import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';
import 'package:flutter_sample/ui/common_widget/genre_card.dart';
import 'package:flutter_sample/vo/type_show_all.dart';

import '../../../constants.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final MovieDetailResponse movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      child: Wrap(
        runSpacing: 12,
        children: movie.genres
            .map((e) => GenreCard(
                  genre: e,
                  space: 4,
                  onItemClick: (genre) => Navigator.pushNamed(
                      context, RouteConfig.ROUTE_SHOW_ALL,
                      arguments: TypeShowAll(Type.GENRE, genre)),
                ))
            .toList(),
      ),
    );
  }
}
