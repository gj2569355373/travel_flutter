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
import 'package:travel_flutter/page/main/mainHomePage.dart';
import 'package:travel_flutter/utils/http/dio_util.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';
import '../../r.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> with BlocBase{
  SplashCubit() : super(SplashState());
  //跳转页面
  void skips(BuildContext context) => Navigator.of(context).pushReplacementNamed('/loginPage');
  void init(BuildContext context) async {//初始化处理判断是否进入启动页
    int i= SpUtil.getInt(SharedPreferencesKey.key_start,defValue: 0);
    emit(state.clone()..start=i==0..imageUrl="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1607427706161&di=f8b1fe1c123ff2cb061accf7e4862ff4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fmobile%2F2018-05-10%2F5af40f5bbac79.jpg");
    if(i!=0) {
      _http();
      _startTimerUtil(context);
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
      if(state._timerUtil!=null)
        state._timerUtil.cancel();
      emit(state.clone()..httpShow=true);
      var map={"grant_type": "password","username":'13420516645',"password":'516645',"scope":"ui","client_id":"browser","client_secret":"server"};
      request.login(map).then((value) {
        emit(state.clone()..httpShow=false);
        if(value)
          NavigatorUtil.pushPage(context,MyHomePage());
        print("----------------Http Log----------------" +value.toString());
      },onError: (Object err, StackTrace stackTrace){
        emit(state.clone()..httpShow=false);
      });
  }
  void _startTimerUtil(BuildContext context){
    if(state._timerUtil!=null)
      return;
    state._timerUtil=new TimerUtil(mTotalTime: state.count * 1000);
    state._timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      emit(state.clone()..count=_tick.toInt());
      if (_tick == 0) {
        next(context);
      }
    });
    state._timerUtil.startCountDown();
  }
}
