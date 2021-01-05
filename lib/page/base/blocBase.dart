/*
 * create by gj
 * Created in 2020/12/9 5:18 下午
 * description: 
 * */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/http/externalRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

abstract class BlocBase {
  final ExternalRequest request = new ExternalRequest();
  void showToast(String msg){

  }
  void onRefresh();
  void onLoading();
}

abstract class BaseCubit extends Cubit<StateBase> with BlocBase{
  BaseCubit(StateBase state) : super(state);
}

abstract class CountDownWith extends Cubit<StateBase> with BlocBase{
  CountDownWith(StateBase state) : super(state);

  void updateCountDown(int count);
}