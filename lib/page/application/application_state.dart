part of 'application_cubit.dart';

// ignore: must_be_immutable
class ApplicationInitial extends StateBase{
  Color themeColor;
  String registerId;
  SpecificLocalizationDelegate localeOverrideDelegate;

  ApplicationInitial(
      {this.localeOverrideDelegate,
      this.themeColor = Colors.deepOrange}); //  final Color themeColor;

  ApplicationInitial clone() {
    // TODO: implement clone
    return ApplicationInitial(
        themeColor: themeColor, localeOverrideDelegate: localeOverrideDelegate)
      ..registerId = this.registerId;
  }
}

