part of 'home_bloc.dart';

class HomeInitEvent extends BaseEvent{
}
class HomeTypeItemEvent extends BaseEvent{
  final BuildContext context;
  final TypeGoto data;

  HomeTypeItemEvent(this.context, this.data);
}
class HomeTypeItemMoreEvent extends BaseEvent{
}
class HomePanelEvent extends BaseEvent{
  final String dropDownValue;

  HomePanelEvent(this.dropDownValue);

}

class HomePanelBinEvent extends BaseEvent{
  final BuildContext context;
  final PanelBin data;

  HomePanelBinEvent(this.context, this.data);
}