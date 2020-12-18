/*
 * create by gj
 * Created in 2020/12/17 4:49 下午
 * description:
 * 应用监听
 * 将帮助我们观察应用程序中所有状态变化的方法
 * */
import 'package:flutter_bloc/flutter_bloc.dart';

class TravelObserver extends BlocObserver {//全局监听
  @override
  void onEvent(Bloc bloc, Object event) {//bloc Event触发
//    print('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {//bloc 状态过度触发
//    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(Cubit cubit, Change change) {//Cubit 状态变更触发
//    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {//Cubit 错误触发
//    print('${cubit.runtimeType} $error $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}