import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel_flutter/http/http_model.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/eventBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<BaseEvent, HomeState> with BlocBase {
  HomeBloc() : super(HomeInitial());


  @override
  Stream<HomeState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToStateHomeInitial
    if (event is RefreshEvent) {
      //下拉刷新

    }
//    else if (event is LoadingEvent){//上拉
//
//    }
    else if (event is HomeInitEvent) {
      //初始化
      yield state.clone()..httpShow = true;
      yield await getBanner();
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

  Future<HomeState> getBanner() async {
    return request
        .getBanner()
        .then((value) => state.clone(newList: value)..httpShow = false,
            onError: (Object err, StackTrace stackTrace) {
      showToast(err.toString());
      return state.clone()..httpShow = false;
    });
  }

  //状态变更 属于Cubit的方法 Change { currentState: 0, nextState: 1 }
  @override
  void onChange(Change<HomeState> change) {
//    print(change);
    super.onChange(change);
  }

  //Bloc独有  状态过度 先于onChange执行，由旧状态，事件、新状态构成；
  // Transition { currentState: 0, event: CounterEvent.increment, nextState: 1 }
  @override
  void onTransition(Transition<BaseEvent, HomeState> transition) {
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
