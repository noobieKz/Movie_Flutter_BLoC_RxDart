import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/backdrop_rating.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: locator<MovieDetailBloc>(),
      child: _MovieDetailWidget(
        movieId: movieId,
      ),
    );
  }
}

class _MovieDetailWidget extends StatefulWidget {
  final int movieId;

  const _MovieDetailWidget({Key key, this.movieId}) : super(key: key);

  @override
  __MovieDetailWidgetState createState() => __MovieDetailWidgetState();
}

class __MovieDetailWidgetState extends State<_MovieDetailWidget> {
  MovieDetailBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<MovieDetailBloc>();
    _bloc.getMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: StreamBuilder<BaseState>(
        stream: _bloc.movieDetailStream,
        builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
          if (snapshot.hasData) {
            BaseState state = snapshot.data;
            return _handleStreamState(state, context);
          } else {
            return ErrorLoading(
              message: "Fetch data not handle..",
              height: MediaQuery.of(context).size.height,
            );
          }
        },
      ),
    );
  }

  Widget _handleStreamState(BaseState state, BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    if (state is StateLoading) {
      return LoadingProgress(
        height: maxHeight,
      );
    } else if (state is StateLoaded<MovieDetailResponse>) {
      MovieDetailResponse movie = state.value;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackdropRating(
              size: MediaQuery.of(context).size,
              movie: movie,
            )
          ],
        ),
      );
    } else if (state is StateError) {
      return ErrorLoading(
        message: state.msgError,
        height: maxHeight,
      );
    } else {
      return ErrorLoading(
        message: "Unknown Error",
        height: maxHeight,
      );
    }
  }
}
