import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerItems;
  HmSlider({Key? key, required this.bannerItems}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  Widget _getSlider() {
    // 屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;
    // 轮播图
    return CarouselSlider(
      carouselController: _carouselController,
      items: List.generate(widget.bannerItems.length, (int index) {
        return Image.network(
          widget.bannerItems[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        onPageChanged: (int index, CarouselPageChangedReason reason) => {
          setState(() {
            _currentIndex = index;
          }),
        },
      ),
    );
  }

  // 搜索框
  Widget _getSearchBox() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            '搜索...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 轮播控制按钮
  Widget _getCarouselControls() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerItems.length, (int index) {
            return GestureDetector(
              onTap: () {
                _carouselController.animateToPage(index);
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _currentIndex == index ? 40 : 10,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_getSlider(), _getSearchBox(), _getCarouselControls()],
    );
  }
}
