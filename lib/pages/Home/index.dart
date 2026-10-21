import 'package:flutter/material.dart';
import 'package:flutter_shop/api/home.dart';
import 'package:flutter_shop/components/Home/HmMoreList.dart';
import 'package:flutter_shop/components/Home/HmSlider.dart';
import 'package:flutter_shop/components/Home/HmHot.dart';
import 'package:flutter_shop/components/Home/HmSuggestion.dart';
import 'package:flutter_shop/components/Home/Hmcategory.dart';
import 'package:flutter_shop/utils/ToastUtils.dart';
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
  // 爆款推荐数据
  SpecialRecommend _inVogueRecommend = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );
  // 一站买全数据
  SpecialRecommend _oneStopRecommend = SpecialRecommend(
    id: '',
    title: '',
    subTypes: [],
  );
  // 推荐商品列表数据
  List<GoodDetailItem> _recommendItems = [];

  // 页码
  int _pageNum = 1;
  int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true; // 是否还有下一页

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
              Expanded(
                child: HmHot(result: _inVogueRecommend, type: 'hot'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopRecommend, type: 'step'),
              ),
            ],
          ),
        ),
      ),
      // 间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 商品列表
      HmMoreList(goodsItems: _recommendItems),
    ];
  }

  @override
  void initState() {
    super.initState();
    _registerScrollListener();
    Future.microtask(() {
      _paddingTop = 50;
      setState(() {});
      _key.currentState?.show();
    });
  }

  void _registerScrollListener() {
    _scrollController.addListener(() {
      // 滚动到最底部时，加载下一页数据
      if (_scrollController.position.pixels <=
          _scrollController.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
  }

  // 初始化轮播图数据
  Future<void> _initBannerList() async {
    _bannerItems = await getBannerListApi();
  }

  // 初始化分类数据
  Future<void> _initCategoryList() async {
    _categoryItems = await getCategoryListApi();
  }

  // 初始化特惠推荐数据
  Future<void> _initSpecialRecommendList() async {
    _specialRecommend = await getSpecialRecommendListApi();
  }

  // 初始化爆款推荐数据
  Future<void> _initInVogueList() async {
    _inVogueRecommend = await getInVogueListApi();
  }

  // 初始化一站买全数据
  Future<void> _initOneStopList() async {
    _oneStopRecommend = await getOneStopListApi();
  }

  // 初始化商品列表数据
  Future<void> _getRecommendList() async {
    // 加载中或没有更多数据了，放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int limit = _pageSize * _pageNum - 1;
    _recommendItems = await getRecommendListApi({"limit": limit});
    _isLoading = false;
    setState(() {});
    // 请求10条数据，判断是否有还有下一页数据
    if (_recommendItems.length < limit) {
      _hasMore = false;
      return;
    }
    _pageNum++;
  }

  Future<void> _onRefresh() async {
    _pageNum = 1;
    _hasMore = true;
    _isLoading = false;
    try {
      await _initBannerList();
      await _initCategoryList();
      await _initSpecialRecommendList();
      await _initInVogueList();
      await _initOneStopList();
      await _getRecommendList();
    } catch (e) {
      if (!mounted) return;
      ToastUtils.showToast(context, '刷新失败，请稍后重试');
      return;
    }
    _paddingTop = 0;
    setState(() {});
    if (!mounted) return;
    ToastUtils.showToast(context, '刷新成功');
  }

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getSlivers(),
        ),
      ),
    );
  }
}
