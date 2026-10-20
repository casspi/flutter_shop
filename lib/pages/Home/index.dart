import 'package:flutter/material.dart';
import 'package:flutter_shop/api/home.dart';
import 'package:flutter_shop/components/Home/HmMoreList.dart';
import 'package:flutter_shop/components/Home/HmSlider.dart';
import 'package:flutter_shop/components/Home/HmHot.dart';
import 'package:flutter_shop/components/Home/HmSuggestion.dart';
import 'package:flutter_shop/components/Home/Hmcategory.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据
  List<BannerItem> _bannerItems = [];
  // 分类数据
  List<CategoryItem> _categoryItems = [];

  // 特惠推荐数据
  SpecialRecommend _specialRecommend = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );
  // 滚动容器组件
  List<Widget> _getSlivers() {
    return [
      // 使用Sliver家族组件包裹普通组件
      // 轮播图
      SliverToBoxAdapter(child: HmSlider(bannerItems: _bannerItems)),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 分类
      SliverToBoxAdapter(child: HmCategory(categoryItems: _categoryItems)),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 搜索建议
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommend: _specialRecommend),
      ),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 商品列表
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 商品列表
      HmMoreList(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _initBannerList();
    _initCategoryList();
    _initSpecialRecommendList();
  }

  // 初始化轮播图数据
  void _initBannerList() async {
    _bannerItems = await getBannerListApi();
    setState(() {});
  }

  // 初始化分类数据
  void _initCategoryList() async {
    _categoryItems = await getCategoryListApi();
    setState(() {});
  }

  // 初始化特惠推荐数据
  void _initSpecialRecommendList() async {
    _specialRecommend = await getSpecialRecommendListApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getSlivers());
  }
}
