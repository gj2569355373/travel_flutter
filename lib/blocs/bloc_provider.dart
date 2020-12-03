import 'package:flutter/material.dart';

abstract class BlocBase {
  Future getData({String labelId, int page});

  Future onRefresh({String labelId});

  Future onLoadMore({String labelId});

  void dispose();
}

/*
* 刷新加载响应体
* */
class RefreshLoadState{
  int type;//刷新响应类型 1成功 2失败 3没有更多数据
  String message;

  RefreshLoadState(this.type, {this.message});
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,//@required注解来标识一个命名参数，这代表该参数是必须的，你不传则会报错
    @required this.bloc,
    this.userDispose: true,
  }) : super(key: key);

  final T bloc;
  final Widget child;
  final bool userDispose;

  @override
  BlocProviderState<T> createState() => BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {

    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);//返回给定类型的最近祖先窗口小部件，它必须是具体窗口小部件子类的类型
    return provider.bloc;//返回实际组件；
  }
  getContent(){

  }
  static Type _typeOf<T>() => T;//返回了当前应用
}

class BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
