import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onItemClick;

  const MovieListWidget({Key key, this.movies, this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        InkWell(
          highlightColor: Colors.black12,
          splashColor: Colors.blueGrey.withOpacity(0.4),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(children: [
              Text(
                "Discover",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
              ),
              Spacer(),
              FaIcon(
                FontAwesomeIcons.arrowRight,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              )
            ]),
          ),
        ),
        Container(
          height: 270.0,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                child: GestureDetector(
                  onTap: () {
                    onItemClick(movies[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      movies[index].posterPath == null
                          ? Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle,
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
                              width: 120.0,
                              height: 180.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w200/" +
                                      movies[index].posterPath,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
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
                        width: 100,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movies[index].voteAverage.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar.builder(
                              unratedColor: Colors.white54,
                              itemSize: 8.0,
                              initialRating: movies[index].voteAverage / 2,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
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
            },
          ),
        ),
      ],
    );
  }
}
