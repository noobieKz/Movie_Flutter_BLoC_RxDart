import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(Movie) onItemClick;
  final double width;
  final bool isCenter;
  final double height;
  final double titleSize;
  final double ratingSize;

  MovieItem(
      {Key key,
      this.movie,
      this.onItemClick,
      this.width,
      this.height,
      this.isCenter,
      this.titleSize = 11,
      this.ratingSize = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
      child: GestureDetector(
        onTap: () {
          onItemClick(movie);
        },
        child: Column(
          crossAxisAlignment:
              isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: <Widget>[
            movie.posterPath == null
                ? Container(
                    width: width,
                    height: height,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: kColorChipItem,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 60.0,
                        )
                      ],
                    ),
                  )
                : Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kColorChipItem),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w200/" + movie.posterPath,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: width - 20,
              child: Text(
                movie.title,
                maxLines: 2,
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: titleSize),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment:
                  isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize - 1,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5.0,
                ),
                RatingBar.builder(
                    unratedColor: Colors.white54,
                    itemSize: ratingSize,
                    initialRating: movie.voteAverage / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
