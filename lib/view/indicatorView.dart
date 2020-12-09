import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class IndicatorView extends StatefulWidget{
  bool show;

  IndicatorView(this.show);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseState();
  }
}
class BaseState extends State<IndicatorView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Offstage(
      offstage: !widget.show,
      child: Container(
        color: Colors.black26,
        alignment: Alignment.center,
        child: SpinKitFadingCube(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,//Theme.of(context).accentColor
            ),
          );
        },
        size: 30.0,
      ),),
    );
  }

}