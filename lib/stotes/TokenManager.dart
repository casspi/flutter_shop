import 'package:flutter_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  String _token = '';
  // 初始化
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? '';
  }

  // 设置token
  Future<void> setToken(String val) async {
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 移除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY); // 磁盘
    _token = ''; // 内存
  }
}

final TokenManager tokenManager = TokenManager();
