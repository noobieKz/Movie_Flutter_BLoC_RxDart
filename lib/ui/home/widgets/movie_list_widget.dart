import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/movie_item.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:flutter_sample/utils/utils.dart';
import 'package:flutter_sample/vo/type_show_all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../home_state.dart';

// ignore: must_be_immutable
class MovieListWidget extends StatelessWidget {
  final Function(Movie) onItemClick;
  HomeBloc _homeBloc;

  MovieListWidget({Key key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _homeBloc = context.watch<HomeBloc>();
    return Column(children: [
      SizedBox(
        height: 16,
      ),
      InkWell(
        highlightColor: Colors.black12,
        splashColor: Colors.blueGrey.withOpacity(0.4),
        onTap: () {
          Navigator.pushNamed(context, RouteConfig.ROUTE_SHOW_ALL,
              arguments: TypeShowAll(Type.DISCOVER, null));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(children: [
            Text(
              "Discover",
              style: TextStyle(
                  color: kTextColor, fontWeight: FontWeight.w600, fontSize: 26),
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
      StreamBuilder<BaseState>(
          stream: _homeBloc.moviesDiscover,
          builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
            if (snapshot.hasData) {
              BaseState state = snapshot.data;
              return _handleStreamState(220, state);
            } else {
              return ErrorLoading(
                message: "Fetch data not handler..",
                height: 270,
              );
            }
          }),
    ]);
  }

  Widget _handleStreamState(double width, BaseState state) {
    if (state is StateLoading) {
      return LoadingProgress(
        height: width + 50,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      return Container(
        height: 270.0,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieItem(
              isCenter: false,
              movie: movies[index],
              width: 120,
              height: 180,
              onItemClick: (item) {
                goDetailScreen(context, item.id);
              },
            );
          },
        ),
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
}
