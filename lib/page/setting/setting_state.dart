part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends StateBase {}

class SetLangState extends StateBase {
  final String lang;

  SetLangState(this.lang);

}