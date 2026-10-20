// 封装api 返回业务侧数据
import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/home.dart';

// 轮播图接口
Future<List<BannerItem>> getBannerListApi() async {
  return (await dioRequest.get(ApiConstants.BANNER_LIST) as List<dynamic>).map((
    item,
  ) {
    return BannerItem.fromJson(item);
  }).toList();
}

// 分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  return (await dioRequest.get(ApiConstants.CATEGORY_LIST) as List<dynamic>)
      .map((item) {
        return CategoryItem.fromJson(item as Map<String, dynamic>);
      })
      .toList();
}

// 特惠推荐
Future<SpecialRecommend> getSpecialRecommendListApi() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(ApiConstants.PRODUCT_LIST),
  );
}
