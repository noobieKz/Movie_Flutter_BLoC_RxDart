import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/ui/common_widget/image_loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CastCard extends StatelessWidget {
  final Cast cast;

  static const PREFIX = "https://image.tmdb.org/t/p/w500";

  const CastCard({Key key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: kDefaultPadding),
      width: 80,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 80,
            width: 80,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kColorChipItem),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: (cast.profilePath == null)
                  ? Icon(
                      Icons.account_circle,
                      color: Colors.white54,
                      size: 60,
                    )
                  : ImageLoader(
                      width: 80,
                      height: 80,
                      imageUrl: PREFIX + cast.profilePath,
                    ),
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            cast.originalName,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
            maxLines: 2,
          ),
          SizedBox(height: kDefaultPadding / 4),
          Text(
            cast.knownForDepartment,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
