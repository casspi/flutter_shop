import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/home.dart';

// 猜你喜欢
/// params: {
///   'page': 1,
///   'pageSize': 10,
/// }
Future<GoodsDetailsItems> getGuessListApi(Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJson(
    await dioRequest.get(ApiConstants.GUESS_LIST, params: params),
  );
}
