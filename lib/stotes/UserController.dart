import 'package:flutter_shop/viewmodels/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJson({}).obs; // user对象被监听，当user对象发生变化时，会自动更新视图
  void updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
