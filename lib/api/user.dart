// 登录接口
import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/user.dart';

Future<UserInfo> loginApi(Map<String, dynamic> data) async {
  return UserInfo.fromJson(
    await dioRequest.post(ApiConstants.LOGIN, data: data),
  );
}
