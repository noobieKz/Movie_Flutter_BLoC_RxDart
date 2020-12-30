import 'package:flutter/material.dart';

import '../../constants.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({Key key, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Color(0xFF243142), borderRadius: BorderRadius.circular(20)),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {},
        child: Text(
          genre,
          style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 16),
        ),
      ),
    );
  }
}
