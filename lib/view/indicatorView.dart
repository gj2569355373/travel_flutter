import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
enum SpinkitEnum {
  //效果见 https://github.com/jogboms/flutter_spinkit
  PouringHourGlass,//沙漏指示器
  FadingCube,//网格追随
  Ring,//实线圆环
  Circle,//虚线圆环
}
// ignore: must_be_immutable
class IndicatorView extends StatefulWidget{

  bool show;
  final SpinkitEnum mode;

  IndicatorView(this.show,{this.mode=SpinkitEnum.PouringHourGlass});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseState();
  }
}
class BaseState extends State<IndicatorView> {
  final double size=30.0;
  Widget _buildSpinKit(BuildContext context){
    switch(widget.mode)
    {
      case SpinkitEnum.PouringHourGlass:
        return SpinKitPouringHourglass(color: Theme.of(context).primaryColor,size: size);
      case SpinkitEnum.FadingCube:
        return SpinKitFadingCube(color: Theme.of(context).primaryColor,
          size: size
        );
      case SpinkitEnum.Ring:
        return SpinKitWanderingCubes(color: Theme.of(context).primaryColor, shape: BoxShape.circle,size: size);
      case SpinkitEnum.Circle:
        return SpinKitCircle(color: Theme.of(context).primaryColor,size: size);
      default:
        return SpinKitPouringHourglass(color: Theme.of(context).primaryColor,size: size);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Offstage(
      offstage: !widget.show,
      child: Container(
        color: Colors.black26,
        alignment: Alignment.center,
        child: _buildSpinKit(context),),
    );
  }

}