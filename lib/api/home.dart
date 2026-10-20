// 封装api 返回业务侧数据

import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  return (await dioRequest.get(ApiConstants.BANNER_LIST) as List<dynamic>).map((
    item,
  ) {
    return BannerItem.fromJson(item);
  }).toList();
}
