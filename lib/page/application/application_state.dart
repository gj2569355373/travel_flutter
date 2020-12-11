part of 'application_cubit.dart';

@immutable
abstract class ApplicationState {
  final Color themeColor;

  ApplicationState(this.themeColor);
//    final JPush jPush = new JPush();
  ApplicationState clone({Color themeColors});
}

// ignore: must_be_immutable
class ApplicationInitial extends ApplicationState {
  String registerId;
//  final Color themeColor;
  ApplicationInitial(themeColor,{this.registerId=""}) : super(themeColor??Colors.deepOrange);

  @override
  ApplicationState clone({Color themeColors}) {
    // TODO: implement clone
    return ApplicationInitial(themeColors??themeColor,registerId: registerId);
  }
}
