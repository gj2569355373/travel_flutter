import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/SharedPreferencesKey.dart';
import 'package:travel_flutter/page/application/application_cubit.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<StateBase> {
  SettingCubit() : super(SettingInitial());

  void init() {
    emit(SetLangState(SpUtil.getString(SharedPreferencesKey.key_language, defValue: 'en')));
  }

  void setLang(String languageCode,BuildContext context) {
    SpUtil.putString(SharedPreferencesKey.key_language, languageCode);
    BlocProvider.of<ApplicationCubit>(context).onLangChanged(languageCode);
    emit(SetLangState(languageCode));
  }
  void setTheme(String colorKey,BuildContext context) {
    SpUtil.putString(SharedPreferencesKey.key_theme_color, colorKey);
    BlocProvider.of<ApplicationCubit>(context).onThemeChanged(colorKey);
  }
}
