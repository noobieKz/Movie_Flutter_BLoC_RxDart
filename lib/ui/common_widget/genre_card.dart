import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';

import '../../constants.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;
  final Function(Genre) onItemClick;
  final double space;

  const GenreCard({Key key, this.genre, this.onItemClick, this.space = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: space),
      decoration: BoxDecoration(
          color: kColorChipItem, borderRadius: BorderRadius.circular(20)),
      child: FlatButton(
        splashColor: kColorItemDarker,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          onItemClick(genre);
        },
        child: Text(
          genre.name,
          style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 16),
        ),
      ),
    );
  }
}
