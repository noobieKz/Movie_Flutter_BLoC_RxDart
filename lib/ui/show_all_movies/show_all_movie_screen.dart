import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/movie_item.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:provider/provider.dart';
import 'show_all_movie_bloc.dart';

class ShowAllMovieScreen extends StatelessWidget {
  final Category category;

  const ShowAllMovieScreen({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: locator<ShowAllMovieBloc>(),
      child: _ShowAllMovieWidget(
        category: category,
      ),
    );
  }
}

class _ShowAllMovieWidget extends StatefulWidget {
  final Category category;

  const _ShowAllMovieWidget({Key key, this.category}) : super(key: key);

  @override
  _ShowAllMovieWidgetState createState() => _ShowAllMovieWidgetState();
}

class _ShowAllMovieWidgetState extends State<_ShowAllMovieWidget> {
  ShowAllMovieBloc _bloc;
  ScrollController _controller;
  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2;
  int _crossAxisCount = 2;

  @override
  void initState() {
    _bloc = context.read<ShowAllMovieBloc>();
    _bloc.getMovieByCategoryFirstPage(widget.category);
    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _bloc.requestMore(widget.category);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.category.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.category.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: bgColor,
      body: StreamBuilder<BaseState>(
        stream: _bloc.moviesByCategory,
        builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
          if (snapshot.hasData) {
            BaseState state = snapshot.data;
            return _handleStreamState(state);
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

  Widget _handleStreamState(BaseState state) {
    double maxHeight = MediaQuery.of(context).size.height;
    if (state is StateLoading) {
      return LoadingProgress(
        height: maxHeight,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      return Container(
        alignment: Alignment.center,
        child: ListView.builder(
          controller: _controller,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            if ((index == movies.length - 1) && _bloc.hasMoreData) {
              return Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator()));
            }
            return MovieItem(
              movie: movies[index],
              width: MediaQuery.of(context).size.width / 4 * 3,
              height: 180,
              onItemClick: (item) {},
              isCenter: true,
              titleSize: 16,
              ratingSize: 12,
            );
          },
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
