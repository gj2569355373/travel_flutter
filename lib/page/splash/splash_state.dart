part of 'splash_cubit.dart';

class SplashState {
  bool start; //用来标识显示进入启动页还是引导页 true 为首次进入，显示引导页
  TimerUtil _timerUtil;
  int count;
  List<String> guideList = [
    R.assetsImgStart1,
    R.assetsImgStart2,
    R.assetsImgStart3
  ];
  List<Widget> bannerList = new List();
  String imageUrl;

  SplashState({this.start = false,this.count=5});

  SplashState clone() {
    return SplashState()
      ..count=count
      ..start = start
      .._timerUtil = _timerUtil
      ..bannerList=bannerList
      ..imageUrl=imageUrl;
  }
}
