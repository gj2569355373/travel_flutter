import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_flutter/http/http_model.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/models/listRowBin.dart';
import 'package:travel_flutter/models/panelBin.dart';
import 'package:travel_flutter/models/typeItem.dart';
import 'package:travel_flutter/page/base/eventBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/res/styles.dart';
import 'package:travel_flutter/utils/locale/translations.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';
import 'package:travel_flutter/view/indicator_view.dart';
import 'package:travel_flutter/view/swiper_style_utils.dart';
import 'home_bloc.dart';

/*
 * create by gj
 * Created in 2020/12/15 2:58 下午
 * description: 首页
 * */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtil.e("HomePageState build.......");
    return
      BlocProvider(
          child: Scaffold(
              appBar: AppBar(
                title: Text(Translations.of(context).text(Constant.main_home)),
              ),
              body: RefresherWidget()),
          create: (BuildContext context) => HomeBloc());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RefresherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RefresherState();
  }
}

class RefresherState extends State<RefresherWidget> {
  HomeBloc _homeBloc;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(HomeInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtil.e("RefresherState build.......");
    return Stack(children: <Widget>[
      SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () {
            _homeBloc.add(RefreshEvent(refreshController));
          },
          onLoading: () => _homeBloc.add(LoadingEvent(refreshController)),
          header: WaterDropHeader(),
          child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                BlocBuilder<HomeBloc, StateBase>(buildWhen: (previousState, currentState){
                    return (currentState is HomeInitial);
                },builder: (context, state) {
//                  LogUtil.e("BlocBuilder listBanner build.......${state.runtimeType}");
                  if (state is HomeInitial) {
                    return _buildBanner(context, state.listBanner);
                  }
                  else
                    return  Container(height: 0.0,);
                }),
                BlocBuilder<HomeBloc, StateBase>(buildWhen: (previousState, currentState){
                  return (currentState is HomeTypeItem);
                },builder: (context, state){
                  if (state is HomeTypeItem)
                    return domainStream(context,state.list);
                  else
                    return  Container(height: 0.0,);
                }),
                BlocBuilder<HomeBloc, StateBase>(buildWhen: (previousState, currentState){
                  return (currentState is HomeLabelPanel);
                },builder: (context, state){
                  if (state is HomeLabelPanel)
                    return getLabelPanel(state);
                  else
                    return  Container(height: 0.0,);
                }),
                BlocBuilder<HomeBloc, StateBase>(buildWhen: (previousState, currentState){
                  return (currentState is HomePanel);
                },builder: (context, state){
                  if (state is HomePanel)
                    return homePanel(context,state.list);
                  else
                    return  Container(height: 0.0,);
                }),
                BlocBuilder<HomeBloc, StateBase>(buildWhen: (previousState, currentState){
                  return (currentState is HomeRowBin);
                },builder: (context, state){
                  if (state is HomeRowBin)
                    return _buildHomeRow(state.list);
                  else
                    return  Container(height: 0.0,);
                }),
              ])),
      IndicatorView<HomeBloc>()
    ]);
  }

  Widget _buildHomeRow(List<ListRowBin> listData){
    return Column(
      children: listData.map((value) {
        return ListTile(
          title: Text(
            value.text,
            style: const TextStyle(fontSize: 18.0),
          ),
          trailing: new Icon(value.icon, color: Colors.red),
          onTap: () {
            //点击监听
            // Add 9 lines from here...
          },
        );
      }).toList(),
    );
  }

  Widget _buildBanner(context, List<BannerModel> snapshot) {
    if (ObjectUtil.isEmpty(snapshot)) {
      return new Container(height: 0.0);
    }
    return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Swiper(
          indicatorAlignment: AlignmentDirectional.topEnd,
          circular: true,
          interval: const Duration(seconds: 5),
          indicator: NumberSwiperIndicator(),
          children: snapshot.map((model) {
            return new InkWell(
              onTap: () {
                LogUtil.e("BannerModel: " + model.toString());
                NavigatorUtil.pushWeb(context,
                    title: model.title, url: model.url);
              },
              child: new CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: model.imagePath,
                placeholder: (context, url) => new ProgressView(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            );
          }).toList(),
        ));
  }

  Widget domainStream(context, List<TypeItem> listData) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          //纵轴(水平)方向间距
          itemCount: listData.length > 8 ? 8 : listData.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //禁用滑动事件
          itemBuilder: (context, i) {
            if (listData.length > 8 && i == 7) {
              return InkWell(
                onTap: ()=>_homeBloc.add(new HomeTypeItemMoreEvent()),
                child: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
              );
            }
            return InkWell(
                onTap: () {
                  _homeBloc.add(new HomeTypeItemEvent(context,listData[i]));
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getImage(listData[i]),
                      Container(
                        height: 10,
                      ),
                      Text(listData[i].title,
                          style: TextStyles.typeListName)
                    ],
                  ),
                ));
          }),
    );
  }

  Widget getLabelPanel(HomeLabelPanel homeLabelPanel) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text('订单看板', style: TextStyle(fontSize: 15)),
            margin: EdgeInsets.only(left: 10),
          ),
          Expanded(
            flex: 1,
            child: Text(''),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text('周期', style: TextStyle(fontSize: 14)),
            margin: EdgeInsets.only(right: 10),
          ),
          getDropdownButton(homeLabelPanel.dropDownValue, <String>['天', '周', '月'], (String v){
            if(homeLabelPanel.dropDownValue==v)
              return;
            _homeBloc.add(new HomePanelEvent(v));
          })
        ],
      ),
    );
  }

  Widget homePanel(context, List<PanelBin> listData) {
    return Container(
      color: Theme.of(context).accentColor,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
          //纵轴(水平)方向间距
          itemCount: 8,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //禁用滑动事件
          itemBuilder: (context, i) {
            return Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () =>_homeBloc.add(new HomePanelBinEvent(context,listData[i])),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(listData[i].count,
                              style: TextStyles.typeListTitle),
                          Container(
                            height: 10,
                          ),
                          Text(listData[i].title,
                              style: TextStyles.typeListName)
                        ],
                      ),
                    )));
          }),
    );
  }


  Widget getDropdownButton(String v, List<String> list, onTap(String value)) {
    return DropdownButton<String>(
        value: v,
        style: TextStyle(color: Theme.of(context).accentColor),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              child: Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              value: value);
        }).toList(),
        onChanged: (String value) {
          onTap(value);
        });
  }

  Widget getImage(TypeItem data) {
    return ClipRRect(
      child: new CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: data.image,
        placeholder: (context, url) => new ProgressView(),
        height: 40,
        width: 40,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }
}


