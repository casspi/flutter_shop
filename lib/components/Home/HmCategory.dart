import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  // 分类数据
  final List<CategoryItem> categoryItems;
  HmCategory({Key? key, required this.categoryItems}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryItems.length,
        itemBuilder: (context, index) {
          // 分类数据
          final categoryItem = widget.categoryItems[index];
          return Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 214, 231, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(categoryItem.picture, width: 40, height: 40),
                Text(
                  categoryItem.name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
