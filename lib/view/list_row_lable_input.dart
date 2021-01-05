/*
 * create by gj
 * Created in 2020/12/29 11:08 上午
 * description: 列表内的组件
 * */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_flutter/res/styles.dart';

class RowLableInput extends StatelessWidget{
  final String hintText;
  final String nameText;
  final String lableText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color kPrimaryColor;
  var _initController = new TextEditingController();
  RowLableInput(this.hintText, this.lableText, this.icon,
      this.onChanged, {this.kPrimaryColor, this.nameText}){
    if(this.nameText!=null) {
      _initController.text = this.nameText;
//      _initController.selection=TextSelection.fromPosition(
//          TextPosition(
//            affinity: TextAffinity.downstream,
//            offset: this.nameText.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        color: Colors.white,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
        Container(margin:EdgeInsets.only(left: 20),alignment:Alignment.center,child: Text(lableText,
            style: TextStyles.rowLableNameStyle),),
        Expanded(
          child: Container(
              alignment: Alignment.centerRight,
              child:
              TextField(
                maxLines: 1,
                textAlign: TextAlign.right,
                controller: _initController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 20),
                  hintText: hintText,
                  hintStyle: TextStyles.hintStyle,
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  onChanged(value);},
                autofocus: false,
              )
    ),
          flex: 1,
        )
      ],),);
  }
}