import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/page/application/application_cubit.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

part 'forgetPassword_state.dart';

class ForgetPasswordCubit extends CountDownWith with BlocBase {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  String userName;
  String password;
  String code;
  void init(BuildContext context){
    BlocProvider.of<ApplicationCubit>(context).checkCountDown(context,2);
  }
  void changName(String text){
    userName=text;
  }
  void changPassWord(String text){
    password=text;
  }
  void changCode(String text){
    code=text;
  }
  void back(BuildContext context){
    Navigator.pop(context);
  }
  void changePassword(BuildContext context){//重置密码
//    NavigatorUtil.pushPage(context,RegisterPage() );
  }

  void sendCode(BuildContext context){
    BlocProvider.of<ApplicationCubit>(context).onCountDownForgetPassword();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    print("close ForgetPasswordCubit");
    return super.close();
  }
  @override
  void updateCountDown(int count)=>emit(CountDownState(count));

  @override
  void onLoading() {
    // TODO: implement onLoading
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }
}
