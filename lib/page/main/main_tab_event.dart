part of 'main_tab_bloc.dart';

@immutable
abstract class MainTabEvent {
  const MainTabEvent();
}
class MainInitEvent extends MainTabEvent {}
///切换NavigationRail的tab
