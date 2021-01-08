import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_detail_response.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/common_widget/common_button.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:flutter_sample/ui/home/widgets/person_list_widget.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/backdrop_rating.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/cast_and_crew.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/description_movie.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/genre_list.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/movie_gallery.dart';
import 'package:flutter_sample/ui/movie_detail/widgets/title_and_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    _bloc.getMovieGallery(widget.movieId);
    _bloc.getCastAndCrew(widget.movieId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("main detail rebuild");
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
            ),
            SizedBox(height: kDefaultPadding / 2),
            TitleAndInfo(
              movie: movie,
              onAddClick: (movie) => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  backgroundColor: kColorChipItem,
                  context: context,
                  builder: (_) {
                    return _bottomSheet;
                  }),
            ),
            GenreList(movie: movie),
            DescriptionMovie(movie: movie),
            SizedBox(height: kDefaultPadding / 2),
            MovieGallery(),
            CastAndCrew(),
            SizedBox(
              height: 50,
            ),
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

  Widget get _bottomSheet => Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4,
            ),
            SizedBox(
              width: 16,
              height: 2,
              child: Container(
                color: Colors.white54,
              ),
            ),
            Spacer(),
            CommonButton(
              onClick: (){},
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              icon: Icon(
                Icons.bookmark_rounded,
                color: Colors.white,
              ),
              title: Text(
                "Mask as watched",
                style: TextStyle(color: Colors.white),
              ),
            ),
            CommonButton(
              onClick: (){},
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: Text(
                "Add to favorite list",
                style: TextStyle(color: Colors.white),
              ),
            ),
            CommonButton(
              onClick: (){},
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              icon: Icon(
                Icons.watch_later,
                color: Colors.white,
              ),
              title: Text(
                "Watch it later",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(),
          ],
        ),
      );
}
