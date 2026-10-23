import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/user.dart';
import 'package:flutter_shop/stotes/TokenManager.dart';
import 'package:flutter_shop/stotes/UserController.dart';
import 'package:flutter_shop/utils/ToastUtils.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 开发模式下带默认账号密码
  final TextEditingController _phoneController = TextEditingController(
    text: '13200000001',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '123456',
  );
  final UserController _userController = Get.find();

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        '账号密码登录',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '请输入手机号';
        }
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return '请输入正确的手机号';
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '请输入手机号',
        fillColor: Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '请输入密码';
        }

        // 6-10位字母数字组合
        if (value.length < 6 ||
            value.length > 10 ||
            !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
          return '密码长度必须在6-10位之间，只能包含字母和数字';
        }
        return null;
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '请输入密码',
        fillColor: Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  bool _isChecked = false;
  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey, width: 2),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '查看并同意'),
              TextSpan(
                text: '《用户协议》',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: '和'),
              TextSpan(
                text: '《隐私政策》',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _login() async {
    try {
      // 调用接口
      final res = await loginApi({
        'account': _phoneController.text,
        'password': _passwordController.text,
      });
      // 登录成功后，更新用户信息
      _userController.updateUserInfo(res);
      await tokenManager.setToken(res.token);
      // 登录成功后，跳转到首页
      ToastUtils.showToast(context, '登录成功');
      Navigator.pop(context);
    } catch (e) {
      ToastUtils.showToast(context, (e as DioException).message, width: 200);
    }
  }

  // 登录按钮
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          // 校验表单是否有效
          if (_formKey.currentState!.validate()) {
            if (_isChecked) {
              await _login();
            } else {
              ToastUtils.showToast(context, '请先同意用户协议', width: 200);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text('登录', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 20),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildPasswordTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
