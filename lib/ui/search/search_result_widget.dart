import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/movie_item.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:flutter_sample/ui/search/search_bloc.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../utils.dart';

class SearchResultWidget extends StatefulWidget {
  final Function onLoadMore;

  const SearchResultWidget({Key key, this.onLoadMore}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  ScrollController _controller;
  SearchBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<SearchBloc>();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        widget.onLoadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: StreamBuilder<BaseState>(
        stream: _bloc.movieResults,
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

  Widget _handleStreamState(BaseState state, context) {
    double maxHeight = MediaQuery.of(context).size.height;
    if (state is StateLoading) {
      return LoadingProgress(
        height: maxHeight,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      print("eeeeeeee" + movies.length.toString());
      if (movies.isEmpty) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 180 / 3,
                color: Colors.white70,
              ),
              Text(
                "Oops! No data here...",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        child: GridView.builder(
          controller: _controller,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            if ((movies[index] == null) && _bloc.hasMoreData) {
              return Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()),
              );
            }
            return MovieItem(
              movie: movies[index],
              width: 150,
              height: 180,
              onItemClick: (item) {
                goDetailScreen(context, item.id);
              },
              isCenter: true,
              titleSize: 16,
              ratingSize: 12,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3 / 5),
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
