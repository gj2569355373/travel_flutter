import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/page/application/application_cubit.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
part 'register_state.dart';
class RegisterCubit extends CountDownWith {
  RegisterCubit() : super(RegisterInitial());
  String userName;
  String password;
  String code;
  void init(BuildContext context){
    BlocProvider.of<ApplicationCubit>(context).checkCountDown(context,1);
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
  void register(BuildContext context){
//    NavigatorUtil.pushPage(context,RegisterPage() );
  }

  void sendCode(BuildContext context){
    BlocProvider.of<ApplicationCubit>(context).onCountDownRegister();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    print("close RegisterCubit");
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
