import 'package:bloc/bloc.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import '../../r.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState());
  //跳转页面
  void skips(BuildContext context) => Navigator.of(context).pushReplacementNamed('/loginPage');
  void init(BuildContext context) async {//初始化处理判断是否进入启动页
    await SpUtil.getInstance();//shared_preferences初始化
    int i= SpUtil.getInt(SharedPreferencesKey.key_start,defValue: 0);
    emit(state.clone()..start=i==0..imageUrl="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1607427706161&di=f8b1fe1c123ff2cb061accf7e4862ff4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fmobile%2F2018-05-10%2F5af40f5bbac79.jpg");
    if(i!=0)
      _startTimerUtil(context);
  }


  void next(BuildContext context,{bool one=false}){
      if(one)
        SpUtil.putInt(SharedPreferencesKey.key_start, 1);
      if(state._timerUtil!=null)
        state._timerUtil.cancel();
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
