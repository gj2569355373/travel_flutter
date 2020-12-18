import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/utils/locale/translations.dart';
import 'package:travel_flutter/view/indicator_view.dart';

import 'my_bloc.dart';
/*
 * create by gj
 * Created in 2020/12/15 2:58 下午
 * description: 首页
 * */
class MyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        child: MyWidget(),
        create: (BuildContext context) => MyBloc());
  }
}
class MyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<MyBloc,MyState>(builder: (context, state){
      return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text(Constant.main_my)),
        ),
        body:  new Stack(children:<Widget>[Container(),IndicatorView<MyBloc>()]),
      );
    });
  }
}