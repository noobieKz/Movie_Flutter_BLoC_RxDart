import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/constants.dart';

class RatingDialog extends StatefulWidget {
  final String title;
  final String description;

  const RatingDialog({Key key, this.title, this.description}) : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rateValue = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: bgColor,
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(widget.title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          RatingBar(
            initialRating: _rateValue,
            unratedColor: Colors.white54,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            onRatingUpdate: (rating) {
              setState(() {
                _rateValue = rating;
              });
            },
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rounded,
                color: Colors.blueAccent,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: Colors.blueAccent,
              ),
              empty: Icon(
                Icons.star_border_rounded,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.white10,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Text(
              "Submit",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context, _rateValue * 2);
            },
          ),
        ],
      ),
    );
  }
}
