import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_flutter/page/application/application_cubit.dart';
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
    return BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
      return MaterialApp(
        theme: ThemeData.light().copyWith(
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
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: localeUtil.supportedLocales(),
        routes: <String, WidgetBuilder>{
          '/mainPage': (BuildContext context) => new MainTabPage(),
//          '/loginPage': (BuildContext context) => new LoginPage()
        },
      );
    });
  }
}
