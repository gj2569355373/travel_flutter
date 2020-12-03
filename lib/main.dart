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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(Translations.of(context).text("about_page_slogan")),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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