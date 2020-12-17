import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_flutter/http/http_model.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/page/base/eventBase.dart';
import 'package:travel_flutter/utils/locale/translations.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';
import 'package:travel_flutter/view/indicatorView.dart';
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text(Constant.main_home)),
        ),
        body: RefresherBloc());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RefresherBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        child: RefresherWidget(),
        create: (BuildContext context) => HomeBloc()..add(HomeInitEvent()));
  }
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: <Widget>[
      SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () {
            _homeBloc.add(RefreshEvent());
          },
          onLoading: () => _homeBloc.add(LoadingEvent()),
          header: WaterDropHeader(),
          child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  if (state is HomeInitial)
                    return _buildBanner(context, state.listBanner);
                  else
                    return Container();
                })
              ])),
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return IndicatorView(state.httpShow);
      })
    ]);
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
}

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
