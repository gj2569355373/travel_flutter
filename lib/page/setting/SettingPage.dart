/*
 * create by gj
 * Created in 2020/12/24 9:45 上午
 * description: 设置页面
 * */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/models/listRowBin.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/page/setting/setting_cubit.dart';
import 'package:travel_flutter/res/colors.dart';

class SettingPage extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) => SettingCubit()..init(),
        child: Scaffold(
          appBar: AppBar(
            title: new Text(Translations.of(context).text(Constant.setting)),
          ),
          body: _buildSuggestions(context),
        ));
  }

  Widget _buildSuggestions(BuildContext context) {
    List<ListRowBin> _lists = [
      ListRowBin(1, Translations.of(context).text(Constant.setTheme),
          Icons.color_lens),
      ListRowBin(
          0, Translations.of(context).text(Constant.language), Icons.language)
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int i) {
        if (_lists[i].type == 1) {
          return _theme(context, _lists[i]);
        } else if (_lists[i].type == 0) return _buildRow(context, _lists[i], i);
        return Container(
          height: 1,
        );
      },
      itemCount: _lists.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 0.5, color: Colors.grey[400]);
      },
    );
  }

  Widget _buildRow(BuildContext context, ListRowBin pair, i) {
    //返回listview显示样式
    return new ListTile(
      title: new Row(
        children: <Widget>[
          Icon(
            Icons.language,
            color: Colours.gray_66,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              pair.text,
              style: _biggerFont,
            ),
          )
        ],
      ),
      trailing: _rowLang(context),
      onTap: () => showSimpleDialog(context),
    );
  }

  Widget _rowLang(BuildContext context) {
    return BlocBuilder<SettingCubit, StateBase>(
        buildWhen: (previousState, currentState) {
      return (currentState is SetLangState);
    }, builder: (BuildContext context, StateBase state) {
      if (state is SetLangState)
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_getLangString(context, state),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colours.gray_99,
                )),
            Container(
              child: Icon(Icons.radio_button_checked, size: 15),
              margin: EdgeInsets.only(left: 10.0),
            ),
          ],
        );
      else
        return Row(mainAxisSize: MainAxisSize.min, children: []);
    });
  }

  Widget _theme(BuildContext context, ListRowBin pair) {
    return new ExpansionTile(
      title: new Row(
        children: <Widget>[
          Icon(
            pair.icon,
            size: 25,
            color: Colours.gray_66,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              pair.text,
              style: _biggerFont,
            ),
          )
        ],
      ),
      children: <Widget>[
        new Wrap(
          children: themeColorMap.keys.map((String key) {
            Color value = themeColorMap[key];
            return new InkWell(
              onTap: () =>
                  BlocProvider.of<SettingCubit>(context).setTheme(key, context),
              child: new Container(
                margin: EdgeInsets.all(5.0),
                width: 36.0,
                height: 36.0,
                color: value,
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  String _getLangString(BuildContext context, SetLangState state) {
    switch (state.lang) {
      case 'en':
        return Translations.of(context).text(Constant.languageEN);
      case 'zh':
        return Translations.of(context).text(Constant.languageZH);
      default:
        return Translations.of(context).text(Constant.languageEN);
    }
  }

  void showSimpleDialog(BuildContext context) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext contexts) {
        return new SimpleDialog(
          title: new Text(Translations.of(context).text(Constant.setLanguage),
              style: TextStyle(
                fontSize: 14.0,
                color: Colours.gray_99,
              )),
          children: <Widget>[
            new SimpleDialogOption(
              child:
                  new Text(Translations.of(context).text(Constant.languageEN)),
              onPressed: () => onTapDialog(contexts, context, "en"),
            ),
            new SimpleDialogOption(
              child:
                  new Text(Translations.of(context).text(Constant.languageZH)),
              onPressed: () => onTapDialog(contexts, context, "zh"),
            ),
          ],
        );
      },
    );
  }

  void onTapDialog(BuildContext contextDialog, BuildContext context, key) {
    Navigator.of(contextDialog).pop();
    BlocProvider.of<SettingCubit>(context).setLang(key, context);
  }
}
