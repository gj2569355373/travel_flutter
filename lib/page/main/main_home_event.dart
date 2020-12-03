part of 'main_home_bloc.dart';

@immutable
abstract class MainHomeEvent {
  const MainHomeEvent();
}
///切换NavigationRail的tab
class SwitchTabEvent extends MainHomeEvent{
  final int selectedIndex;

  const SwitchTabEvent({@required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
///展开NavigationRail,这个逻辑比较简单,就不用传参数了
class IsExtendEvent extends MainHomeEvent{
  const IsExtendEvent();

  @override
  List<Object> get props => [];
}