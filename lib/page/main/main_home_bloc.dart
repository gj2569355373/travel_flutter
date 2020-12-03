import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_home_event.dart';

part 'main_home_state.dart';

class MainHomeBloc extends Bloc<MainHomeEvent, MainHomeState> {
  MainHomeBloc() : super(MainHomeState());

  @override
  Stream<MainHomeState> mapEventToState(MainHomeEvent event) async* {
    // TODO: implement mapEventToState
    ///main_view中添加的事件，会在此处回调，此处处理完数据，将数据yield，BlocBuilder就会刷新组件
    if (event is SwitchTabEvent) {
      ///获取到event事件传递过来的值,咱们拿到这值塞进MainState中
      ///直接在state上改变内部的值,然后yield,只能触发一次BlocBuilder,它内部会比较上次MainState对象,如果相同,就不build
      yield MainHomeState()//返回
        ..selectedIndex = event.selectedIndex
        ..isExtended = state.isExtended;
    } else if (event is IsExtendEvent) {
      yield MainHomeState()
        ..selectedIndex = state.selectedIndex
        ..isExtended = !state.isExtended;
    }
  }
}
