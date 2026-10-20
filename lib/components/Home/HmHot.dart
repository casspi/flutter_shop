import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HmHot extends StatefulWidget {
  final SpecialRecommend result;
  final String type;
  const HmHot({super.key, required this.result, required this.type});

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  String get _subTitle => widget.type == 'hot' ? '最受欢迎' : '精心优选';
  List<GoodsItem> get _goodsItems {
    if (widget.result.subTypes.isEmpty) {
      return [];
    } else {
      return widget.result.subTypes.first.goodsItems.items.take(2).toList();
    }
  }

  // 标题栏
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.result.title,
          style: TextStyle(
            color: const Color.fromARGB(255, 91, 44, 44),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text(
          _subTitle,
          style: TextStyle(
            color: const Color.fromARGB(255, 91, 44, 44),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 子项列表
  List<Widget> _buildChildrenList() {
    return _goodsItems
        .map(
          (item) => Expanded(
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      width: 80,
                      height: 100,
                      item.picture,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color.fromARGB(255, 242, 109, 109),
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: const Color.fromARGB(255, 238, 167, 167),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      '¥${item.price}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 232, 87, 34),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: widget.type == 'hot'
            ? const Color.fromARGB(255, 136, 206, 246)
            : const Color.fromARGB(255, 222, 248, 179),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildChildrenList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
