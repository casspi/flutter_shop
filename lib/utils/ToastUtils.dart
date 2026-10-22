import 'package:flutter/material.dart';

class ToastUtils {
  static bool isShow = false;
  // 阀门控制，避免重复显示
  static void showToast(BuildContext context, String? msg, {width = 120}) {
    if (ToastUtils.isShow) {
      return;
    }
    ToastUtils.isShow = true;
    // 3秒后重置状态
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.isShow = false;
    });

    // 数据获取成功，刷新成功提示
    final Size size = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // width 与 margin 互斥，这里用 margin 控制宽度并让提示居中显示
        margin: EdgeInsets.only(
          left: (size.width - width) / 2,
          right: (size.width - width) / 2,
          bottom: size.height / 2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        content: Text(msg ?? '请求成功', textAlign: TextAlign.center),
      ),
    );
  }
}
