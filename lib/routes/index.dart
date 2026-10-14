// 管理路由
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/Login/index.dart';
import 'package:flutter_shop/pages/Main/index.dart';

// 返回App根组件
Widget getRootWidget() {
  return MaterialApp(
    // 命名路由
    routes: getRootRoutes(),
    initialRoute: '/',
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {'/': (context) => MainPage(), 'login': (context) => LoginPage()};
}
