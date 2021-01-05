import 'package:flutter/material.dart';
import 'package:travel_flutter/r.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final double statusBarHeight = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              R.assetsImgMainTop,
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              R.assetsImgLoginBottom,
              width: size.width * 0.4,
            ),
          ),
          Container(
//            alignment: Alignment.topCenter,
//            padding: EdgeInsets.only(top: 30+statusBarHeight),
            child: child,)
        ],
      ),
    );
  }
}
