import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/page/main/main_tab_bloc.dart';
import '../../utils/locale/translations.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';

class MainTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///创建BlocProvider的，表明该Page，我们是用MainHomeBloc，MainHomeBloc是属于该页面的Bloc了
    return BlocProvider(
        child: _TabPageWidget(),
        create: (BuildContext context) => MainTabBloc());
  }
}

class _TabPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainTabBloc, MainTabState>(builder: (context, state) {
      return new DefaultTabController(
          //无状态Tab控制器
          length: state.allPages.length,
          child: Scaffold(
            //可显示带抽屉、已经
//          appBar: AppBar( //标题栏控件
//            title: new Text(title),
//            automaticallyImplyLeading: true, //设为false可以关闭自动插入返回键以及抽屉的操作
//          ),
            body: TabViewLayout(),
            bottomNavigationBar: new Material(child: BottomTabBarLayout()),
          ));
    });
  }
}

class BottomTabBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainTabBloc, MainTabState>(builder: (context, state) {
      return new TabBar(
        indicatorColor: Theme.of(context).accentColor,
        labelColor: Theme.of(context).accentColor,
        unselectedLabelColor: Theme.of(context).buttonColor,
        isScrollable: false,
        indicatorWeight: 2,
        tabs: state.allPages
            .map((String page) => new Tab(
                text: Translations.of(context).text(page), icon: getIcon(page)))
            .toList(),
      );
    });
  }

  Icon getIcon(String labelId) {
    switch (labelId) {
      case Constant.main_home:
        return Icon(Icons.home);
      case Constant.main_extend:
        return Icon(Icons.business);
      case Constant.main_my:
        return Icon(Icons.school);
      default:
        return Icon(Icons.school);
        break;
    }
  }
}

//body
class TabViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.e("TabViewLayout build.......");
    return BlocBuilder<MainTabBloc, MainTabState>(builder: (context, state) {
      return new TabBarView(
          children:
              state.allPages.map((String page) => getPage(page)).toList());
    });
  }
}
