
import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleAndInfo extends StatelessWidget {
  final MovieDetailResponse movie;
  final ValueChanged<MovieDetailResponse> onAddClick;

  const TitleAndInfo({Key key, this.movie, this.onAddClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: <Widget>[
                    Text(
                      '${movie.releaseDate}',
                      style: TextStyle(color: kTextLightColor),
                    ),
                    SizedBox(width: kDefaultPadding),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      _getTime(),
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 55,
            width: 55,
            child: FlatButton(
              onPressed: () {
                onAddClick(movie);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getTime() {
    int hour = movie.runtime ~/ 60;
    int minute = movie.runtime - hour * 60;
    return "${hour}h ${minute}min";
  }
}
