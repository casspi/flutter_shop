import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialRecommend specialRecommend;
  const HmSuggestion({Key? key, required this.specialRecommend})
    : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 获取3条数据
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommend.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommend.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  // 构建标题
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '搜索建议',
          style: TextStyle(
            color: const Color.fromARGB(255, 116, 53, 53),
            fontSize: 18,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '精选省钱攻略',
          style: TextStyle(
            color: const Color.fromARGB(255, 141, 47, 35),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 构建左侧内容
  Widget _buildLeftContent() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(ImageConstants.SUGGESTION_LEFT),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _buildChildrenList() {
    List<GoodsItem> goodsItems = _getDisplayItems();
    return goodsItems.map((item) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 140,
                  color: const Color.fromARGB(255, 238, 167, 167), // 背景色
                );
              },
              item.picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
              // 图片加载中显示背景色
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 100,
                    height: 140,
                    color: const Color.fromARGB(255, 238, 167, 167), // 背景色
                    child: child,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 87, 34),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '¥${item.price}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('lib/assets/images/suggestion-bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftContent(),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
