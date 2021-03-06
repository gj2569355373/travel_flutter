import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/forgetPassword/ForgetPasswordPage.dart';
import 'package:travel_flutter/page/register/RegisterPage.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<StateBase> with BlocBase {
  String userName;
  String password;

  LoginCubit() : super(LoginInitial());

  void init() {}

  void changName(String text) {
    print(text);
    userName = text;
  }

  void changPassWord(String text) {
    print(text);
    password = text;
  }

  void forgetPassword(context) {
    NavigatorUtil.pushPage(context, ForgetPasswordPage());
  }

  void register(context) {
    NavigatorUtil.pushPage(context, RegisterPage());
  }

  void wechat(context) {}

  void instagram(context) {}

  void login(BuildContext context) {
    emit(HttpState(true));
    var map = {
      "grant_type": "password",
      "username": '13420516645',
      "password": '516645',
      "scope": "ui",
      "client_id": "browser",
      "client_secret": "server"
    };
    request.login(map).then((value) {
      emit(HttpState(false));
      if (value) Navigator.of(context).pushReplacementNamed('/mainPage');
    }, onError: (Object err, StackTrace stackTrace) {
      emit(HttpState(false));
    });
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }
}
