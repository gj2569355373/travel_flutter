part of 'main_tab_bloc.dart';

@immutable
abstract class MainState {
  final List<String> allPages = <String>[
    Constant.main_home,
//    Constant.main_extend,
    Constant.main_my,
  ];
}
class MainTabState extends MainState {
  ///初始化方法,基础变量也需要赋初值,不然会报空异常
  MainTabState();

  ///clone方法,此方法实现参考fish_redux的clone方法
  ///也是对官方Flutter Login Tutorial这个demo中copyWith方法的一个优化
  ///Flutter Login Tutorial（https://bloclibrary.dev/#/flutterlogintutorial）
  MainTabState clone() {
    return MainTabState();
  }
}
