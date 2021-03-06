import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/http/api.dart';
import 'package:travel_flutter/http/externalRequest.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/login/LoginPage.dart';
import 'package:travel_flutter/page/main/mainTabPage.dart';
import 'package:travel_flutter/utils/http/dio_util.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';
import '../../r.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<StateBase> with BlocBase{
  TimerUtil _timerUtil;
  final int count=5;
  SplashState splashState;
  Timer timer;
  SplashCubit() : super(SplashState());
  //跳转页面
  void skips(BuildContext context) => Navigator.of(context).pushReplacementNamed('/loginPage');
  void init(BuildContext context) async {//初始化处理判断是否进入启动页
    int i= SpUtil.getInt(SharedPreferencesKey.key_start,defValue: 0);
    emit(SplashState()..start=i==0);
    _http();
    if(i!=0) {
      timer= new Timer(new Duration(seconds: 2), () {
        emit(SplashState().clone()..imageUrl="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1607427706161&di=f8b1fe1c123ff2cb061accf7e4862ff4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fmobile%2F2018-05-10%2F5af40f5bbac79.jpg");
        _startTimerUtil(context);
        timer.cancel();
        timer=null;
      });
    }
  }
  void _http() async {
      _initDio();
  }

  void _initDio() {
    BaseOptions options = DioUtil.getDefOptions(baseUrl: TravelApi.serverAddress);
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  void next(BuildContext context,{bool one=false}){
      if(one)
        SpUtil.putInt(SharedPreferencesKey.key_start, 1);
      if(_timerUtil!=null)
        _timerUtil.cancel();
      Navigator.of(context).pushReplacementNamed('/LoginPage');
  }
  void _startTimerUtil(BuildContext context){
    if(_timerUtil!=null)
      return;
    _timerUtil=new TimerUtil(mTotalTime: splashState.count * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      int _tick = tick ~/ 1000;
      if (_tick == 0) {
        next(context);
      }
      else
        emit(splashState.clone()..count=_tick);
    });
    _timerUtil.startCountDown();
  }
//状态变更 属于Cubit的方法 Change { currentState: 0, nextState: 1 }
  @override
  void onChange(Change<StateBase> change) {
//    print(change);
    if (change.nextState is SplashState) {
      splashState = change.nextState;
    }
    super.onChange(change);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    if(_timerUtil!=null)
      _timerUtil.cancel();
    if(timer!=null)
      timer.cancel();
    return super.close();
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
