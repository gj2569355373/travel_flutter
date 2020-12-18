import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

enum SpinkitEnum {
  //效果见 https://github.com/jogboms/flutter_spinkit
  PouringHourGlass, //沙漏指示器
  FadingCube, //网格追随
  Ring, //实线圆环
  Circle, //虚线圆环
}

class IndicatorView<T extends Cubit<StateBase>> extends StatelessWidget {
  final double size;

  final SpinkitEnum mode;

  IndicatorView({this.size = 30.0, this.mode = SpinkitEnum.PouringHourGlass});

  Widget _buildSpinKit(BuildContext context) {
    switch (mode) {
      case SpinkitEnum.PouringHourGlass:
        return SpinKitPouringHourglass(
            color: Theme.of(context).primaryColor, size: size);
      case SpinkitEnum.FadingCube:
        return SpinKitFadingCube(
            color: Theme.of(context).primaryColor, size: size);
      case SpinkitEnum.Ring:
        return SpinKitWanderingCubes(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
            size: size);
      case SpinkitEnum.Circle:
        return SpinKitCircle(color: Theme.of(context).primaryColor, size: size);
      default:
        return SpinKitPouringHourglass(
            color: Theme.of(context).primaryColor, size: size);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<T, StateBase>(
        buildWhen: (previousState, currentState) => currentState is HttpState,
        builder: (context, state) {
          LogUtil.e(
              "BlocBuilder IndicatorView build.......${state.runtimeType}--${T.toString()}");
          if (state is HttpState) {
            LogUtil.e(
                "IndicatorView httpShow build.......${state.runtimeType}");
            return Offstage(
              offstage: !state.httpB,
              child: Container(
                color: Colors.black26,
                alignment: Alignment.center,
                child: _buildSpinKit(context),
              ),
            );
          } else
            return new Container(height: 0.0);
        });
  }
}
