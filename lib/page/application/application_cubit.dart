import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import 'package:travel_flutter/res/colors.dart';
import 'package:travel_flutter/utils/locale/translations.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationInitial> {
  ApplicationCubit() : super(ApplicationInitial(localeOverrideDelegate: new SpecificLocalizationDelegate(new Locale("en"))));

  void init() async {
    //初始化选择的样式
    await SpUtil.getInstance(); //shared_preferences初始化
    String lang= SpUtil.getString(SharedPreferencesKey.key_language, defValue: 'en');
    String colorKey=SpUtil.getString(SharedPreferencesKey.key_theme_color, defValue: 'deepOrange');
    emit(new ApplicationInitial(themeColor: themeColorMap[colorKey],
        localeOverrideDelegate: new SpecificLocalizationDelegate(new Locale(lang))));
  }

  //触发主题更新
  void onThemeChanged(String colorKey) {
    if (themeColorMap[colorKey] != null) {
      print("onThemeChanged  build");
      emit(state.clone()..themeColor=themeColorMap[colorKey]);
    }
  }
  //触发语言切换
  void onLangChanged(String languageCode) {
    if (languageCode != null) {
      print("onLangChanged  build");
      emit(state.clone()..localeOverrideDelegate=new SpecificLocalizationDelegate(new Locale(languageCode)));
    }
  }
}
