import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import 'package:travel_flutter/res/colors.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationInitial(null));

  void init() async {
    //初始化选择的样式
    await SpUtil.getInstance(); //shared_preferences初始化
    onThemeChanged(SpUtil.getString(SharedPreferencesKey.key_theme_color, defValue: 'deepOrange')); //初始化主题
  }

  //触发主题更新
  void onThemeChanged(String colorKey) {
    if (themeColorMap[colorKey] != null) {
      print("onThemeChanged  build");
      emit(state.clone(themeColors: themeColorMap[colorKey]));
    }
  }
}
