//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:travelflutter/bin/listRowBin.dart';
//import 'package:travelflutter/bin/panelBin.dart';
//import 'package:travelflutter/bin/typeItem.dart';
//import 'package:travelflutter/bin/typeList.dart';
//import 'package:travelflutter/http/protocol/models.dart';
//import 'package:travelflutter/http/request/external_request.dart';
//import 'package:travelflutter/res/res_index.dart';

import 'bloc_provider.dart';

class MainBloc implements BlocBase{
//  ExternalRequest request = new ExternalRequest();
//  BehaviorSubject<List<TypeList>> _extendSubject =BehaviorSubject<List<TypeList>>();
//  Sink<List<TypeList>> get _extendSink =>_extendSubject.sink;//重写临时变量的get方法  输入监听
//  Stream<List<TypeList>> get extendStream =>_extendSubject.stream.asBroadcastStream(); //组件更新流
//
//  BehaviorSubject<List<BannerModel>> _homeBanner = BehaviorSubject<List<BannerModel>>();
//  Sink<List<BannerModel>> get _bannerSink => _homeBanner.sink;//重写临时变量的get方法  输入监听
//  Stream<List<BannerModel>> get bannerStream => _homeBanner.stream.asBroadcastStream(); //组件更新流
//
//  BehaviorSubject<List<ListRowBin>> _homeSubject = BehaviorSubject<List<ListRowBin>>();
//  Sink<List<ListRowBin>> get homeSink => _homeSubject.sink;//重写临时变量的get方法  输入监听
//  Stream<List<ListRowBin>> get homeStream => _homeSubject.stream.asBroadcastStream(); //组件更新流
//
//  BehaviorSubject<List<TypeItem>> _homeCustomDomain = BehaviorSubject<List<TypeItem>>();
//  Sink<List<TypeItem>> get _homeDomainSink => _homeCustomDomain.sink;//重写临时变量的get方法  输入监听
//  Stream<List<TypeItem>> get homeDomainStream => _homeCustomDomain.stream.asBroadcastStream(); //组件更新流
//
//  BehaviorSubject<List<PanelBin>> _homePanel = BehaviorSubject<List<PanelBin>>();
//  Sink<List<PanelBin>> get _homePanelSink => _homePanel.sink;//重写临时变量的get方法  输入监听
//  Stream<List<PanelBin>> get homePanelStream => _homePanel.stream.asBroadcastStream(); //组件更新流

  @override
  void dispose() {
    // TODO: implement dispose
//    _homeSubject.close();
//    _extendSubject.close();
//    _homeBanner.close();
//    _homeCustomDomain.close();
//    _homePanel.close();
  }

  @override
  Future getData({String labelId, int page}) {
    // TODO: implement getData
    switch(labelId){
//      case Ids.main_home:
//        return getHomeDate();
//      case Ids.main_extend:
//        return getExtend();
//      case Ids.main_extend:
//        return getMyDate();
    }
    return null;
  }
//  Future<RefreshLoadState> getHomeDate({int count=0}) async {
//    List<Object> listError=[];
//    //请求刷新banner
//    await request.getBanner().then((list) {
//      _bannerSink.add(list);
//    },onError: (Object err, StackTrace stackTrace){
//      listError.add(err);
//    });
//    //获取自定义域数据源
//    await request.getCustomDomain().then((onValue){
//      _homeDomainSink.add(onValue);
//    },onError: (Object err, StackTrace stackTrace){
//      listError.add(err);
//    });
//    //获取面板数据源
//    await request.getHomePanel().then((onValue){
//      _homePanelSink.add(onValue);
//    },onError: (Object err, StackTrace stackTrace){
//      listError.add(err);
//    });
//
//    if (listError.length>0){
//      return Future.error(listError.toString());
//    }
//    return Future(() => RefreshLoadState(1));
//  }

//  Future<RefreshLoadState> getExtend({int count=0}) async{
//    return request.getTypeListData().then((onValue){
//      _extendSink.add(onValue);
//      return RefreshLoadState(1);
//    });
//  }

  Future getMyDate({int count=0}){
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future<RefreshLoadState> onRefresh({String labelId}) {
    // TODO: implement onRefresh
//    switch(labelId){
//      case Ids.main_home:
//        return getHomeDate();
//      case Ids.main_extend:
//        return getExtend();
//      case Ids.main_extend:
//        return getMyDate();
//    }
    return null;
  }
}