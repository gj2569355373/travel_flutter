/*
 * create by gj
 * Created in 2020/12/8 11:33 上午
 * description: 
 * */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/splash/splash_cubit.dart';
import 'package:travel_flutter/res/colors.dart';
import 'package:travel_flutter/utils/locale/translations.dart';
import 'package:travel_flutter/view/indicator_view.dart';

import '../../r.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    print("SplashPage  build");
    return BlocProvider(
      child: Material(
        child: new Stack(children: <Widget>[
          BlocBuilder<SplashCubit, StateBase>(builder: _getBody),
          IndicatorView<SplashCubit>()
        ]),
      ), //BlocBuilder<SplashCubit, StateBase>(builder: _splashWidget),
      create: (BuildContext context) => SplashCubit()..init(context),
    );
  }

  Widget _getBody(BuildContext context, StateBase state) {
    if (state is SplashState) {
      if (state.start) {
        //判断显示引导页还是启动页
        initBannerData(context, state);
        return new Swiper(
            autoStart: false,
            circular: false,
            indicator: CircleSwiperIndicator(
              radius: 4.0,
              padding: EdgeInsets.only(bottom: 30.0),
              itemColor: Colors.black26,
            ),
            children: state.bannerList);
      } else {
        return new Stack(children: <Widget>[
          new Offstage(
              offstage: ObjectUtil.isNotEmpty(state.imageUrl),
              child: _buildSplashBg()),
          new Offstage(
              offstage: ObjectUtil.isEmpty(state.imageUrl),
              child: _networkImageWidget(state)),
          new Offstage(
            offstage: ObjectUtil.isEmpty(state.imageUrl),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<SplashCubit>(context).next(context);
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      Translations.of(context).text("skip") +
                          state.count.toString(),
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Colours.divider))),
              ),
            ),
          )
        ]);
      }
    }
    else return Container(height: 0.0);
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      R.assetsImgSplashBg,
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  Widget _networkImageWidget(SplashState state) {
    if (ObjectUtil.isEmpty(state.imageUrl)) {
      return new Container(
        height: 0.0,
      );
    }
    return new InkWell(
      onTap: () {
        if (ObjectUtil.isEmpty(state.imageUrl)) return;
//        _goMain();
//        NavigatorUtil.pushWeb(context,
//            title: _splashModel.title, url: _splashModel.url);
      },
      child: new Container(
        alignment: Alignment.center,
        child: new CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          imageUrl: state.imageUrl,
          placeholder: (context, url) => _buildSplashBg(),
          errorWidget: (context, url, error) {
            //进入下一步；
            BlocProvider.of<SplashCubit>(context).next(context);
            return _buildSplashBg();
          },
        ),
      ),
    );
  }

  void initBannerData(BuildContext context, SplashState state) {
    if(state.bannerList.length==0)
    for (int i = 0, length = state.guideList.length; i < length; i++) {
      if (i == length - 1) {
        state.bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              state.guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: new InkWell(
                  onTap: () {
                    BlocProvider.of<SplashCubit>(context)
                        .next(context, one: true);
                  },
                  child: new CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: new Padding(
                      padding: EdgeInsets.all(2.0),
                      child: new Text(
                        Translations.of(context).text("experience"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        state.bannerList.add(new Image.asset(
          state.guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }
}
