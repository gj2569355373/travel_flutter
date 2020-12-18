import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_flutter/http/http_model.dart';
import 'package:travel_flutter/models/listRowBin.dart';
import 'package:travel_flutter/models/panelBin.dart';
import 'package:travel_flutter/models/typeInterface.dart';
import 'package:travel_flutter/models/typeItem.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/eventBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<BaseEvent, StateBase> with BlocBase {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<StateBase> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToStateHomeInitial
    if (event is RefreshEvent) {
      //下拉刷新
//      yield HttpState(true);
      HomeInitial homeInitial = await getBanner();
      if (homeInitial != null) {
        yield homeInitial;
        event.refreshController.refreshCompleted();
      }
      else
        event.refreshController.refreshFailed();
//      yield HttpState(false);
    }
//    else if (event is LoadingEvent){//上拉
//
//    }
    else if (event is HomeInitEvent) {
      yield HttpState(true);
      HomeInitial homeInitial = await getBanner();
      if (homeInitial != null) yield homeInitial;
      HomeTypeItem homeTypeItem = await getHomeTypeItem();
      if (homeTypeItem != null) yield homeTypeItem;
      yield HomeLabelPanel("周");

      HomePanel homePanel = await getHomePanel();
      if (homeTypeItem != null) yield homePanel;
      yield HomeRowBin([
        ListRowBin(0,  "第一条",
            Icons.favorite_border),
        ListRowBin(
            0, "第二条", Icons.favorite_border),
      ]);
      yield HttpState(false);
    }
    else if(event is HomeTypeItemEvent)
      onTap(event.data,event.context);
    else if(event is HomePanelEvent)
      yield HomeLabelPanel(event.dropDownValue);
    else if(event is HomePanelBinEvent)
      onTap(event.data,event.context);
  }

  void onTap(TypeGoto data, context) {
    if (data.urlPage.startsWith("http")) {
      NavigatorUtil.pushWeb(context, title: data.title, url: data.urlPage);
    } else {
      NavigatorUtil.pushPage(context, null,
          pagePath: data.urlPage);
    }
  }
  @override
  void onLoading() {
    // TODO: implement onLoading
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<HomeInitial> getBanner() async {
    return request.getBanner().then((value) => HomeInitial(listBanner: value),
        onError: (Object err, StackTrace stackTrace) {
      showToast(err.toString());
      return null;
    });
  }
  Future<HomeTypeItem> getHomeTypeItem() async {
    return request.getCustomDomain().then((value) => HomeTypeItem(value),
        onError: (Object err, StackTrace stackTrace) {
          showToast(err.toString());
          return null;
        });
  }
  Future<HomePanel> getHomePanel() async {
    return request.getHomePanel().then((value) => HomePanel(value),
        onError: (Object err, StackTrace stackTrace) {
          showToast(err.toString());
          return null;
        });
  }

  //状态变更 属于Cubit的方法 Change { currentState: 0, nextState: 1 }
  @override
  void onChange(Change<StateBase> change) {
//    print(change);
    super.onChange(change);
  }

  //Bloc独有  状态过度 先于onChange执行，由旧状态，事件、新状态构成；
  // Transition { currentState: 0, event: CounterEvent.increment, nextState: 1 }
  @override
  void onTransition(Transition<BaseEvent, StateBase> transition) {
//    print(transition);
    super.onTransition(transition);
  }

  //Bloc独有，监听事件优先触发 早于onTransition
  @override
  void onEvent(BaseEvent event) {
//    print(event);
    super.onEvent(event);
  }
}
