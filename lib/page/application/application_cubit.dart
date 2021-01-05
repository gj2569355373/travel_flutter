import 'package:bloc/bloc.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/forgetPassword/forgetPassword_cubit.dart';
import 'package:travel_flutter/page/register/register_cubit.dart';
import 'package:travel_flutter/res/colors.dart';
import 'package:travel_flutter/utils/locale/locale_util.dart';
import 'package:travel_flutter/utils/locale/translations.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<StateBase> {
  TimerUtil _timerUtilRegister; //注册的全局定时器
  int contextType;
  TimerUtil _timerUtilPassword; //忘记密码的全局定时器
  BuildContext context;
  final int count = 30;
  ApplicationInitial applicationInitial;

  ApplicationCubit()
      : super(ApplicationInitial(
            localeOverrideDelegate:
                new SpecificLocalizationDelegate(new Locale("en"))));

  void init() async {
    //初始化选择的样式
    await SpUtil.getInstance(); //shared_preferences初始化
    String lang =
        SpUtil.getString(SharedPreferencesKey.key_language, defValue: 'en');
    String colorKey = SpUtil.getString(SharedPreferencesKey.key_theme_color,
        defValue: 'deepOrange');
    emit(new ApplicationInitial(
        themeColor: themeColorMap[colorKey],
        localeOverrideDelegate:
            new SpecificLocalizationDelegate(new Locale(lang)))..locale=new Locale(lang,LocaleUtil.getCountryCode(lang)));
  }

  //触发主题更新
  void onThemeChanged(String colorKey) {
    if (themeColorMap[colorKey] != null) {
      print("onThemeChanged  build");
      emit(applicationInitial.clone()..themeColor = themeColorMap[colorKey]);
    }
  }

  //触发语言切换
  void onLangChanged(String languageCode) {
    if (languageCode != null) {
      print("onLangChanged  build");
      emit(applicationInitial.clone()
        ..localeOverrideDelegate =
            new SpecificLocalizationDelegate(new Locale(languageCode)));
    }
  }

  void checkCountDown(BuildContext context, int type) {
    //type1注册2忘记密码
    this.contextType=type;
    this.context = context;
    if (type == 1)
      _updateCountDown<RegisterCubit>(_timerUtilRegister == null
          ? 0
          : _timerUtilRegister.mTotalTime ~/ 1000);
    else if (type == 2)
      _updateCountDown<ForgetPasswordCubit>(_timerUtilPassword == null
          ? 0
          : _timerUtilPassword.mTotalTime ~/ 1000);
  }

  void onCountDownRegister() {
    if (_timerUtilRegister != null) return;
    _timerUtilRegister = new TimerUtil(mTotalTime: count * 1000);
    _timerUtilRegister.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      try {
        if(contextType==1)
        _updateCountDown<RegisterCubit>(tick ~/ 1000);
      } catch (e) {
        print(e);
        this.context = null;
      }
      if (_tick == 0) {
        _timerUtilRegister.cancel();
        _timerUtilRegister = null;
      }
    });
    _timerUtilRegister.startCountDown();
  }

  void onCountDownForgetPassword() {
    if (_timerUtilPassword != null) return;
    _timerUtilPassword = new TimerUtil(mTotalTime: count * 1000);
    _timerUtilPassword.setOnTimerTickCallback((int tick) {
      try {
        if(contextType==2)
        _updateCountDown<ForgetPasswordCubit>(tick ~/ 1000);
      } catch (e) {
        print(e);
        this.context = null;
      }
      if (tick ~/ 1000 == 0) {
        _timerUtilPassword.cancel();
        _timerUtilPassword = null;
      }
    });
    _timerUtilPassword.startCountDown();
  }

  _updateCountDown<T extends CountDownWith>(int count) {
    if (this.context != null) {
      BlocProvider.of<T>(context).updateCountDown(count);
    }
  }

  @override
  void onChange(Change<StateBase> change) {
//    print(change);
    if (change.nextState is ApplicationInitial) {
      applicationInitial = change.nextState;
    }
    super.onChange(change);
  }
}
