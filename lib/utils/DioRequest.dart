// 基于Dio的请求工具类
import 'package:dio/dio.dart';
import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/stotes/TokenManager.dart';

class DioRequest {
  static Dio _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _addInterceptors();
  }

  // 拦截器
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          // 每次请求前，添加token
          if (tokenManager.getToken().isNotEmpty) {
            request.headers['Authorization'] =
                "Bearer ${tokenManager.getToken()}";
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          // http 状态码判断
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data['msg'] ?? " ",
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 进一步处理返回结果
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> response = await task;
      final data = response.data as Map<String, dynamic>; // data 为接口真实返回数据
      if (data['code'] != GlobalConstants.SUCCESS_CODE) {
        throw DioException(
          requestOptions: response.requestOptions,
          message: data['msg'] ?? "加载失败",
        );
      }
      return data['result'];
    } catch (e) {
      // throw Exception(e);
      rethrow;
    }
  }
}

// 单例对象
final DioRequest dioRequest = DioRequest();
