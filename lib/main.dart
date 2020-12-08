import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'page/main/mainHomePage.dart';
import 'page/splash/SplashPage.dart';
import 'utils/locale_util.dart';
import 'utils/translations.dart';
import 'r.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color _themeColor = Colors.deepOrange;
//    final JPush jPush = new JPush();
    String registerId;
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          primaryColor: _themeColor,
          accentColor: _themeColor,
          buttonColor: _themeColor,
          indicatorColor: Colors.white,
          backgroundColor: Colors.grey[50],
          toggleableActiveColor: _themeColor,//部分按钮颜色，如Radio
          appBarTheme: AppBarTheme(textTheme: TextTheme(title: TextStyle(fontSize: 18.0,)))//标题样式
      ),
      home: SplashPage(),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: localeUtil.supportedLocales(),
      routes:
      <String,WidgetBuilder>{
//        '/onePage':(BuildContext context) => new OnePage('简单布局'),
//        '/twoPage':(BuildContext context) => new TwoPage('list列表布局'),
//        '/threePage':(BuildContext context) => new ThreePage(),
//        '/loginPage':(BuildContext context) => new LoginPage(),
//        '/mainPage':(BuildContext context) => new MainPage(),
      },
    );
  }
}
