import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_gallery_response.dart';
import 'package:flutter_sample/ui/common_widget/empty_list_widget.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/image_loader.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:flutter_sample/ui/movie_detail/movie_detail_bloc.dart';
import 'package:provider/provider.dart';

class MovieGallery extends StatefulWidget {
  @override
  _MovieGalleryState createState() => _MovieGalleryState();
}

class _MovieGalleryState extends State<MovieGallery> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BaseState>(
      stream: context.watch<MovieDetailBloc>().movieGalleryStream,
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
    );
  }

  Widget _handleStreamState(BaseState state, BuildContext context) {
    if (state is StateLoading) {
      return LoadingProgress(
        height: 186,
      );
    } else if (state is StateLoaded<MovieGalleryResponse>) {
      MovieGalleryResponse images = state.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              "Screenshots",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          (images.backdrops.isEmpty)
              ? EmptyListWidget(
                  height: 180,
                )
              : Container(
                  height: 180,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    itemCount: images.backdrops.length > 10
                        ? 10
                        : images.backdrops.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _buildItem(images.backdrops[index].filePath, 180),
                  ),
                ),
        ],
      );
    } else if (state is StateError) {
      return ErrorLoading(
        message: state.msgError,
        height: 186,
      );
    } else {
      return ErrorLoading(
        message: "Unknown Error",
        height: 186,
      );
    }
  }

  Widget _buildItem(String imagePath, double itemHeight) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kColorChipItem,
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: ImageLoader(
          width: MediaQuery.of(context).size.width / 3 * 2,
          imageUrl: 'https://image.tmdb.org/t/p/w500$imagePath',
        ),
      ),
    );
  }
}
