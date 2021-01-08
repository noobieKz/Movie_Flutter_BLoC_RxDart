import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';
import 'package:flutter_sample/utils/utils.dart';
import 'package:flutter_sample/vo/type_show_all.dart';
import 'package:flutter_sample/ui/common_widget/background_black_gradient.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/image_loader.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/view_all_button.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MovieListSlider extends StatefulWidget {
  @override
  _MovieListSliderState createState() => _MovieListSliderState();
}

class _MovieListSliderState extends State<MovieListSlider> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<BaseState>(
      stream: _homeBloc.moviesByCategory,
      builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
        if (snapshot.hasData) {
          BaseState state = snapshot.data;
          return _handleStreamState(maxWidth, state);
        } else {
          return ErrorLoading(
            message: "Fetch data not handle..",
            height: maxWidth + 50,
          );
        }
      },
    );
  }

  Widget _handleStreamState(double width, BaseState state) {
    if (state is StateLoading) {
      return LoadingProgress(
        height: width + 50,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      return Container(
        child: Column(children: [
          ViewAllButton(
            label: "View all",
            icon: FaIcon(
              FontAwesomeIcons.arrowRight,
              size: 20,
              color: Colors.white.withOpacity(0.8),
            ),
            onClick: () {
              Navigator.pushNamed(context, RouteConfig.ROUTE_SHOW_ALL,
                  arguments: TypeShowAll<Category>(
                      Type.CATEGORY, _homeBloc.currentCategory));
            },
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
            items: movies.take(7).map((e) => _buildItemSlider(e)).toList(),
          ),
        ]),
      );
    } else if (state is StateError) {
      return ErrorLoading(
        message: state.msgError,
        height: width + 50,
      );
    } else {
      return ErrorLoading(
        message: "Unknown Error",
        height: width + 50,
      );
    }
  }

  Widget _buildItemSlider(Movie movie) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => goDetailScreen(context, movie.id),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kColorChipItem),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
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
      ),
    );
  }
}
