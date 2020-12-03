
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:travelflutter/bin/companyBin.dart';

import 'bloc_provider.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();
  Sink<int> get _appEventSink => _appEvent.sink;
  Stream<int> get appEventStream => _appEvent.stream;

  BehaviorSubject<String> _themeEvent = BehaviorSubject<String>();
  Sink<String> get themeEventSink => _themeEvent.sink;
  Stream<String> get themeEventStream => _themeEvent.stream;

  BehaviorSubject<Locale> _localeEvent = BehaviorSubject<Locale>();
  Sink<Locale> get localeEventSink => _localeEvent.sink;
  Stream<Locale> get localeEventStream => _localeEvent.stream;

//  BehaviorSubject<CompanyBin> companyBinEvent = BehaviorSubject<CompanyBin>();//切换企业监听
//  Sink<CompanyBin> get companySink => companyBinEvent.sink;
//  Stream<CompanyBin> get companyStream => companyBinEvent.stream;

//  List<CompanyBin> listCompany=[CompanyBin('景逸旅行社', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560172731141&di=cfea83c99f7a2e558b0858b1b6699db1&imgtype=0&src=http%3A%2F%2Fimg1.qunarzz.com%2Fp%2Ftts9%2F1805%2F26%2F0f11d12f083bf002.jpg', '')
//  ,CompanyBin('橙光旅行社', 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=354865630,1374999026&fm=15&gp=0.jpg', '')];

  @override
  void dispose() {
    _appEvent.close();
    _themeEvent.close();
    _localeEvent.close();
//    companyBinEvent.close();
  }

  @override
  Future getData({String labelId, int page}) {
    // TODO: implement getData
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    // TODO: implement onRefresh
    return null;
  }

  void sendAppEvent(var value) {
    if(value is int)
      _appEventSink.add(value);
    else if (value is String){
      themeEventSink.add(value);
    }
    else if (value is Locale){
      localeEventSink.add(value);
    }
//    else if (value is CompanyBin){
//      companySink.add(value);
//    }
  }
}
