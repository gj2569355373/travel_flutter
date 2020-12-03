import 'package:flutter/material.dart';
import 'package:travel_flutter/blocs/application_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/bloc_provider.dart';
import 'utils/locale_util.dart';
import 'utils/translations.dart';

void main() {
  runApp(BlocProvider(child: MyApp(),bloc: ApplicationBloc()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}
class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color _themeColor = Colors.deepOrange;
//    final JPush jPush = new JPush();
    String registerId;
    ApplicationBloc bloc;
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
      home: MyHomePage(),
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



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(Translations.of(context).text("about_page_slogan")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Translations.of(context).text("about_page_slogan"),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
