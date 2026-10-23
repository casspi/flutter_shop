import 'package:flutter/material.dart';
import 'package:flutter_shop/api/user.dart';
import 'package:flutter_shop/pages/Cart/index.dart';
import 'package:flutter_shop/pages/Category/index.dart';
import 'package:flutter_shop/pages/Home/index.dart';
import 'package:flutter_shop/pages/Mine/index.dart';
import 'package:flutter_shop/stotes/TokenManager.dart';
import 'package:flutter_shop/stotes/UserController.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  // 定义导航栏数据
  final List<Map<String, dynamic>> _tabList = [
    {
      'icon': 'lib/assets/images/home-0.png',
      "activeIcon": "lib/assets/images/home.png",
      'label': '首页',
    },
    {
      'icon': 'lib/assets/images/message-0.png',
      "activeIcon": "lib/assets/images/message.png",
      'label': '分类',
    },
    {
      'icon': 'lib/assets/images/dianpu-0.png',
      "activeIcon": "lib/assets/images/dianpu.png",
      'label': '购物车',
    },
    {
      'icon': 'lib/assets/images/mine-0.png',
      "activeIcon": "lib/assets/images/mine.png",
      'label': '我的',
    },
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return _tabList
        .map(
          (item) => BottomNavigationBarItem(
            icon: Image.asset(item['icon'], width: 30, height: 30),
            activeIcon: Image.asset(item['activeIcon'], width: 30, height: 30),
            label: item['label'],
          ),
        )
        .toList();
  }

  List<Widget> _pageList() {
    return [
      Center(child: HomeView()),
      Center(child: Category()),
      Center(child: CartView()),
      Center(child: MineView()),
    ];
  }

  final UserController _userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    _initUser();
  }

  _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      _userController.updateUserInfo(await getUserInfoApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IndexedStack(index: _currentIndex, children: _pageList()),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orangeAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: _bottomNavigationBarItems(),
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
