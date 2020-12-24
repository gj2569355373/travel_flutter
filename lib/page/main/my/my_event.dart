part of 'my_bloc.dart';

@immutable
abstract class MyEvent {}

class MyHeadEvent extends BaseEvent{
}
class GotoEvent extends BaseEvent{
  final String path;
  final BuildContext context;
  GotoEvent(this.path,this.context);

}