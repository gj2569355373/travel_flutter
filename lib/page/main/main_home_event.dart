part of 'main_home_bloc.dart';

@immutable
abstract class MainHomeEvent {
  const MainHomeEvent();
}
class MainInitEvent extends MainHomeEvent {}
///切换NavigationRail的tab
class SwitchTabEvent extends MainHomeEvent{
  final int selectedIndex;
  SwitchTabEvent({@required this.selectedIndex});
}
///展开NavigationRail,这个逻辑比较简单,就不用传参数了
class IsExtendEvent extends MainHomeEvent{}