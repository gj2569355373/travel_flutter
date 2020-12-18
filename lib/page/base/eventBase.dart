/*
 * create by gj
 * Created in 2020/12/15 5:08 下午
 * description:Event基类，包括刷新基类等
 * */
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseEvent {
}
class RefreshEvent extends BaseEvent{
  final RefreshController refreshController;

  RefreshEvent(this.refreshController);
}
class LoadingEvent extends BaseEvent{
  final RefreshController refreshController;

  LoadingEvent(this.refreshController);
}