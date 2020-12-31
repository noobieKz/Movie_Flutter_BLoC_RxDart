import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/ui/common/background_black_gradient.dart';
import 'package:flutter_sample/ui/common/image_loader.dart';
import 'package:flutter_sample/ui/common/view_all_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieListSlider extends StatefulWidget {
  final List<Movie> movies;

  const MovieListSlider({Key key, this.movies}) : super(key: key);

  @override
  _MovieListSliderState createState() => _MovieListSliderState(movies);
}

class _MovieListSliderState extends State<MovieListSlider> {
  final List<Movie> movies;

  _MovieListSliderState(this.movies);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "No More Movies",
            style: TextStyle(color: Colors.white),
          )
        ],
      );
    } else {
      var width = MediaQuery.of(context).size.width;
      return Container(
        padding: EdgeInsets.only(top: 8),
        child: Column(children: [
          ViewAllButton(
            label: "View All",
            icon: FaIcon(
              FontAwesomeIcons.arrowRight,
              size: 20,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: width,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 8),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
            ),
            items: movies.map((e) => _buildItemSlider(e)).toList(),
          ),
        ]),
      );
    }
  }

  Widget _buildItemSlider(Movie movie) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  ImageLoader(
                    width: constraints.biggest.width,
                    height: constraints.biggest.height,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BackgroundBlackGradient(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                movie.voteAverage.roundToDouble().toString(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              RatingBar.builder(
                                  unratedColor: Colors.white54,
                                  itemSize: 16.0,
                                  initialRating: movie.voteAverage / 2,
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
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
