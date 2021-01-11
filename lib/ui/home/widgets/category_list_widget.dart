import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';

class CategoryListWidget extends StatefulWidget {
  final Function(Category) onCategoryChange;

  const CategoryListWidget({Key key, this.onCategoryChange}) : super(key: key);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 60,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return _itemCategory(index, context);
        },
        scrollDirection: Axis.horizontal,
        itemCount: listCategory.length,
      ),
    );
  }

  Widget _itemCategory(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedCategory != index) {
              _selectedCategory = index;
              widget.onCategoryChange(listCategory[index]);
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              listCategory[index].name,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w600,
                    color: index == _selectedCategory
                        ? kTextColor
                        : Colors.white.withOpacity(0.4),
                  ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 2),
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == _selectedCategory
                    ? kSecondaryColor
                    : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
