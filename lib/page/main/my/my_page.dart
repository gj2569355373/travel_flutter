import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/models/listRowBin.dart';
import 'package:travel_flutter/utils/locale/translations.dart';
import 'package:travel_flutter/view/indicator_view.dart';
import 'package:travel_flutter/view/swiper_style_utils.dart';

import 'my_bloc.dart';

/*
 * create by gj
 * Created in 2020/12/15 2:58 下午
 * description: 首页
 * */
class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyStates();
  }
}

class MyStates extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        child: MyWidget(), create: (BuildContext context) => MyBloc());
  }
}

class MyWidget extends StatelessWidget {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: new Stack(children: <Widget>[
        Column(children: <Widget>[
          _head(context),
          Container(
              width: 370, height: 1, color: Color.fromARGB(255, 220, 220, 220)),
          Expanded(
            child: _buildSuggestions(context),
            flex: 1,
          )
        ]),
        IndicatorView<MyBloc>()
      ]),
    );
  }

  Widget _buildSuggestions(context) {
    List<ListRowBin> _lists = [
      ListRowBin(0, 'NewOrder', Icons.favorite),
      ListRowBin(
          0, Translations.of(context).text(Constant.setting), Icons.settings),
      ListRowBin(0, 'ProductDetailPage', Icons.favorite),
      ListRowBin(0, '出行人列表', Icons.favorite),
    ];
    return ListView.builder(
        itemCount: _lists.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(_lists[i], i, context);
        });
  }

  Widget _buildRow(ListRowBin pair, i, context) {
    //返回listview显示样式
    return Container(
      child: ListTile(
        leading: new Icon(pair.icon, color: Colors.grey),
        title: Text(
          pair.text,
          style: const TextStyle(fontSize: 18.0),
        ),
        trailing: new Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          //点击监听
          // Add 9 lines from here...
          if (i == 0) {
            BlocProvider.of<MyBloc>(context).add(new GotoEvent("newOrder",context));
          } else if (i == 1)
            BlocProvider.of<MyBloc>(context).add(new GotoEvent("settingPage",context));
          else if (i == 2)
            BlocProvider.of<MyBloc>(context)
                .add(new GotoEvent("ProductDetailPage",context));
          else if (i == 3) {
            BlocProvider.of<MyBloc>(context)
                .add(new GotoEvent("changePasswordPage",context));
          }
        },
      ),
    );
  }

  Widget _head(context) {
    return BlocBuilder<MyBloc, MyState>(
        buildWhen: (previousState, currentState) {
      return (currentState is MyInitial);
    }, builder: (context, state) {
      if (state is MyInitial) {
        return new Material(
            color: Theme.of(context).accentColor, //Colors.white
            child: InkWell(
                highlightColor: Colors.black12,
                splashColor: Colors.blueGrey,
                onTap: () {
                  BlocProvider.of<MyBloc>(context).add(new MyHeadEvent(context));
                },
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        new ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state.myBin.imageUrl,
                            placeholder: (context, url) => new ProgressView(),
                            height: 70,
                            width: 70,
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
//                    CircleAvatar(
//                      backgroundImage: NetworkImage(myBin.imageUrl),
//                      radius: 35.0,
//                    ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              widthFactor: 2.0,
                              heightFactor: 1.5,
                              child: Column(children: <Widget>[
                                Text(
                                  state.myBin.department,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                Text(state.myBin.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        height: 1.5))
                              ])),
                          flex: 1,
                        ),
                      ],
                    ))));
      } else
        return Container(
          height: 0.0,
        );
    });
  }
}
