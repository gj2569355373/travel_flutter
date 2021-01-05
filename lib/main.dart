import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_flutter/page/application/application_cubit.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'page/login/LoginPage.dart';
import 'page/main/mainTabPage.dart';
import 'page/splash/SplashPage.dart';
import 'travel_observer.dart';
import 'utils/locale/locale_util.dart';
import 'utils/locale/translations.dart';

void main() {
  Bloc.observer = TravelObserver();
  runApp(BlocProvider(
      create: (BuildContext context) => ApplicationCubit()..init(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    print("MyApp  build");
    return BlocBuilder<ApplicationCubit, StateBase>(buildWhen: (previousState, currentState) => currentState is ApplicationInitial,
        builder: (context, state) {
//          print("MyApp  BlocBuilder build");
      if (state is ApplicationInitial)
        return MaterialApp(
          theme: ThemeData.light().copyWith(
              platform: TargetPlatform.android,
              primaryColor: state.themeColor,
              accentColor: state.themeColor,
              buttonColor: state.themeColor,
              indicatorColor: Colors.white,
              backgroundColor: Colors.grey[50],
              toggleableActiveColor: state.themeColor,
              //部分按钮颜色，如Radio
              appBarTheme: AppBarTheme(
                  textTheme: TextTheme(
                      title: TextStyle(
                fontSize: 18.0,
              ))) //标题样式
              ),
          home: SplashPage(),
          locale: state.locale,
          localizationsDelegates: [
            state.localeOverrideDelegate,
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
//            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: localeUtil.supportedLocales(),
          routes: <String, WidgetBuilder>{
            '/mainPage': (BuildContext context) => new MainTabPage(),
            '/LoginPage': (BuildContext context) => new LoginPage(),
//          '/loginPage': (BuildContext context) => new LoginPage()
          },
        );
      return new Container(height: 0.0);
    });
  }
}
