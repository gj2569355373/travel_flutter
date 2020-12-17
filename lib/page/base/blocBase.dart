/*
 * create by gj
 * Created in 2020/12/9 5:18 下午
 * description: 
 * */
import 'package:travel_flutter/http/externalRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BlocBase {
  final ExternalRequest request = new ExternalRequest();
  void showToast(String msg){

  }
  void onRefresh();
  void onLoading();
}