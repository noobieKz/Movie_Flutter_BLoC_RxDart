import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/utils/exts.dart';
import 'package:numberpicker/numberpicker.dart';

class BottomSheetFilter extends StatefulWidget {
  @override
  _BottomSheetFilterState createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  int _indexSelected = 3;
  String _valueDropDown = "Popularity ↓";
  List<String> _years = ["2017", "2018", "2019", "2020", "2021", "2022"];
  List<String> _dropdownMenu = [
    "Popularity ↓",
    "Popularity ↑",
    "Release Date ↓",
    "Release Date ↑",
    "Vote Count ↓",
    "Vote Count ↑",
    "Vote Average ↓",
    "Vote Average ↑"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 24),
                  child: Text(
                    "Year",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                height: 50,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (_, index) {
                    return _itemDate(index);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _years.length,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 24),
                  child: Text(
                    "Sort By",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              Spacer(),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: bgColor,
                ),
                child: DropdownButton(
                    value: _valueDropDown,
                    items: _dropdownMenu
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valueDropDown = value;
                      });
                    }),
              ),
              Spacer(),
            ],
          ),
          FlatButton(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.white12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              child: Text(
                "Apply filter",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget _itemDate(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _indexSelected = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          _years[index],
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: (_indexSelected == index) ? Colors.blueGrey : bgColor,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
