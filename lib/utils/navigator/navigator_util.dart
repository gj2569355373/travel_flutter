import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/page/main/home/home_page.dart';
import 'package:travel_flutter/page/main/my/my_page.dart';
import 'package:travel_flutter/page/web/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

//页面启动路由
class NavigatorUtil {
  
  static Future pushPage(BuildContext context, Widget page, {String pagePath}) {//Future接收返回参数
    if (context == null ) return null;
    if(page != null)
      return Navigator.push(context, new CupertinoPageRoute<void>(builder: (ctx) => page));
    if(ObjectUtil.isNotEmpty(pagePath))
      return Navigator.of(context).pushReplacementNamed(pagePath);
    return Future.error("");
  }

  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
              builder: (ctx) => new WebScaffold(
                    title: title,
                    titleId: titleId,
                    url: url,
                  )));
    }
  }

//  static void pushTabPage(BuildContext context,
//      {String labelId, String title, String titleId, TreeModel treeModel}) {
//    if (context == null) return;
//    Navigator.push(
//        context,
//        new CupertinoPageRoute<void>(
//            builder: (ctx) => new BlocProvider<TabBloc>(
//                  child: new TabPage(
//                    labelId: labelId,
//                    title: title,
//                    titleId: titleId,
//                    treeModel: treeModel,
//                  ),
//                  bloc: new TabBloc(),
//                )));
//  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//根据网络参数打开本地页面可以使用
Widget getPage(String name){
  switch(name){
    case Constant.main_home://主页
      return HomePage();
    case Constant.main_my://我的
      return MyPage();
//    case 'twoPage':
//      return TwoPage('简单布局');
//    case 'threePage':
//      return ThreePage();
//    case 'fourPage':
//      return FourPage();
//    case 'newOrder':
//      return NewOrderPage();
    default:
      return Container(child: Text("getPage参数异常，请联系开发人员"),);
  }
}
