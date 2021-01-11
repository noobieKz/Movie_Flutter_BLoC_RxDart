import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/ui/common_widget/image_loader.dart';
import 'package:flutter_sample/ui/common_widget/rating_dialog.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class BackdropRating extends StatefulWidget {
  final Size size;
  final MovieDetailResponse movie;

  const BackdropRating({Key key, this.size, this.movie}) : super(key: key);

  @override
  _BackdropRatingState createState() => _BackdropRatingState();
}

class _BackdropRatingState extends State<BackdropRating> {
  MovieDetailBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<MovieDetailBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.5,
      width: widget.size.width,
      child: Stack(
        children: [
          Container(
            height: widget.size.height * 0.5 - 50,
            decoration: BoxDecoration(
              color: kColorChipItem.withOpacity(0.7),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              child: (widget.movie.backdropPath == null)
                  ? Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_search,
                        size: 100,
                        color: Colors.white70,
                      ),
                    )
                  : ImageLoader(
                      width: widget.size.width,
                      imageUrl:
                          "https://image.tmdb.org/t/p/w780${widget.movie.backdropPath}",
                    ),
            ),
          ),
          //Rating bar
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: widget.size.width * 0.9,
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
                                "${widget.movie.voteAverage}/",
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
                    InkWell(
                      onTap: () async {
                        if (_bloc.isMovieRated(widget.movie.id)) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text("This movie already rated..."),
                          ));
                          return;
                        }
                        double rateValue = await showDialog(
                            context: context,
                            builder: (_) {
                              return RatingDialog(
                                title: "Thanks for the Rating!",
                                description:
                                    "Let us know how much you like this movie?",
                              );
                            });
                        if (rateValue != null) {
                          _bloc.setMovieToRated(widget.movie.id);
                          _rebuild();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text("Thanks you ( ͡° ͜ʖ ͡°)"),
                          ));
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.solidStar,
                            color: _bloc.isMovieRated(widget.movie.id)
                                ? kSecondaryColor
                                : Colors.white,
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
                            "${(widget.movie.voteAverage * 10).toInt()}",
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
                          "${widget.movie.voteCount} reviews",
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
          Positioned(
              bottom: 100,
              right: 50,
              top: 50,
              left: 50,
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_outline_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }

  _rebuild() {
    setState(() {});
  }
}
