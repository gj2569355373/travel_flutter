/*
 * create by gj
 * Created in 2020/12/24 3:08 下午
 * description: 
 * */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/view/indicator_view.dart';
import 'body.dart';
import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: Material(
            child:Stack(children: [_childB(),IndicatorView<LoginCubit>()])
        ));
  }
//  _body
  Widget _childB(){
     return Body();
  }
}
