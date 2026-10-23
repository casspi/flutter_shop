import 'package:flutter/material.dart';
import 'package:flutter_shop/api/mine.dart';
import 'package:flutter_shop/components/Home/HmMoreList.dart';
import 'package:flutter_shop/components/Mine/HmGuess.dart';
import 'package:flutter_shop/stotes/UserController.dart';
import 'package:flutter_shop/utils/ToastUtils.dart';
import 'package:flutter_shop/viewmodels/home.dart';
import 'package:get/get.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  final UserController _userController = Get.find();
  List<Widget> _getSlivers() {
    return [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 260,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (_userController.user.value.id.isEmpty) {
                        Navigator.pushNamed(context, 'login');
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? _userController.user.value.account
                          : '立即登录',
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverPersistentHeader(delegate: HmGuess(), pinned: true),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(goodsItems: _guessList),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
    ];
  }

  List<GoodDetailItem> _guessList = [];
  //分页参数
  Map<String, dynamic> _params = {'page': 1, 'pageSize': 10};

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

  // 注册滚动事件
  void _registerScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <=
          (_scrollController.position.maxScrollExtent - 50)) {
        // 到达底部，加载更多
        _getGuessList();
      }
    });
  }

  // 是否正在加载
  bool _isLoading = false;
  // 是否还有更多数据
  bool _hasMore = true;
  // 猜你喜欢
  Future<void> _getGuessList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    final res = await getGuessListApi(_params);
    _isLoading = false;
    _guessList.addAll(res.items);
    setState(() {});
    if (_params['page'] >= res.pages) {
      _hasMore = false;
      return;
    }
    _params['page']++;
  }

  Future<void> _refresh() async {
    _params['page'] = 1;
    _hasMore = true;
    _isLoading = false;
    _guessList.clear();

    await _getGuessList();
    _paddingTop = 0;
    setState(() {});
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
      onRefresh: _refresh,
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
