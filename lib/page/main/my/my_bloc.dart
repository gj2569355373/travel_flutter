import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:travel_flutter/page/Information/MyInformationPage.dart';
import 'package:travel_flutter/page/base/eventBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/setting/SettingPage.dart';
import 'package:travel_flutter/utils/navigator/navigator_util.dart';

import '../../changePasswordPage.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<BaseEvent, MyState> {
  MyBloc() : super(MyInitial(MyBin('GposSlin', '技术部',
      'http://img3.duitang.com/uploads/item/201509/25/20150925144216_iuEXt.thumb.700_0.jpeg')
  ));

  @override
  Stream<MyState> mapEventToState(
      BaseEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is MyHeadEvent)
        NavigatorUtil.pushPage(event.context,MyInformationPage() );
    else if (event is GotoEvent){
      if(event.path=="settingPage")
        NavigatorUtil.pushPage(event.context,SettingPage() );
      else if(event.path=="changePasswordPage")
        NavigatorUtil.pushPage(event.context,ChangePasswordPage() );
    }
  }
}
