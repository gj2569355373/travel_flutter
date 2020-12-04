part of 'main_home_bloc.dart';


class MainHomeState {
  int selectedIndex;
  bool isExtended;
  ///初始化方法,基础变量也需要赋初值,不然会报空异常
  MainHomeState({this.selectedIndex=0, this.isExtended=false});


  ///clone方法,此方法实现参考fish_redux的clone方法
  ///也是对官方Flutter Login Tutorial这个demo中copyWith方法的一个优化
  ///Flutter Login Tutorial（https://bloclibrary.dev/#/flutterlogintutorial）
  MainHomeState clone() {
    return MainHomeState()
      ..selectedIndex = selectedIndex
      ..isExtended = isExtended;
  }
}
