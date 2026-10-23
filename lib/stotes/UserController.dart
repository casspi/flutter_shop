import 'package:flutter_shop/viewmodels/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJson({}).obs;

  void updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
