import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/ui/common_widget/image_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class BackdropRating extends StatelessWidget {
  final Size size;
  final MovieDetailResponse movie;

  const BackdropRating({Key key, this.size, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.5 - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              child: ImageLoader(
                imageUrl: (movie.backdropPath == null)
                    ? "https://image.tmdb.org/t/p/w780${movie.posterPath}"
                    : "https://image.tmdb.org/t/p/w780${movie.backdropPath}",
              ),
            ),
          ),
          //Rating bar
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                color: kColorChipItem,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: kSecondaryColor,
                        ),
                        SizedBox(height: kDefaultPadding / 4),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(
                                "${movie.voteAverage}/",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "10",
                                style: TextStyle(
                                  textBaseline: TextBaseline.ideographic,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              )
                            ]),
                      ],
                    ),
                    // Rate this
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            print("tap");
                          },
                          child: FaIcon(
                            FontAwesomeIcons.star,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 4),
                        Text(
                          "Rate This",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    // Metascore
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${(movie.voteAverage * 10).toInt()}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 4),
                        Text(
                          "Metascore",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${movie.voteCount} reviews",
                          style:
                              TextStyle(color: kTextLightColor, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              icon: FaIcon(
                FontAwesomeIcons.arrowLeft,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
