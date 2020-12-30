import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/common/genre_card.dart';

class GenreListWidget extends StatelessWidget {
  final List<String> genres;

  const GenreListWidget({Key key, this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GenreCard(
            genre: genres[index],
          );
        },
      ),
    );
  }
}
