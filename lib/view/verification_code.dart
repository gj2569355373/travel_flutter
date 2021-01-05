/*
 * create by gj
 * Created in 2020/12/28 12:22 下午
 * description: 
 * */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/res/styles.dart';

class VerificationCode<T extends Cubit<StateBase>> extends StatelessWidget{
  final String buttonText;
  final String hintText;//输入框提示文本
  final String hintTextTime;//倒计时
  final bool click;
  final Color kPrimaryColor;
  final ValueChanged<String> onChanged;
  final Function onTap;

  VerificationCode(this.buttonText, this.hintText, this.hintTextTime,this.onTap,{this.click=true,this.onChanged,this.kPrimaryColor=const Color(0xFF6F35A5)});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
              child: TextField(
                onChanged: onChanged,
                cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.code,
                      color: kPrimaryColor,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyles.hintStyle,
                    border: InputBorder.none,
                  )
              ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20,top: 4,bottom: 4),
            margin: EdgeInsets.only(right: 10),
          ),
          flex: 1,
        ),
    BlocBuilder<T, StateBase>(
    buildWhen: (previousState, currentState) => currentState is CountDownState,
    builder:(context, state) {
      if (state is CountDownState)
       return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(29),topRight: Radius.circular(29)),
          ),
          padding: EdgeInsets.symmetric(vertical: 19),
          onPressed: onTap,
          color:kPrimaryColor,
          textColor: click?Colors.white:Colors.white70,
          splashColor: Colors.purple[900],
          child: Container(
            margin: EdgeInsets.all(0),
            child: Text(state.time==0?buttonText:hintTextTime+" "+state.time.toString()+" s",style: TextStyle(fontSize: 14),),
            width: 140,
            alignment: Alignment.center,
          ),
        );
      else
        return new Container(height: 0.0);
    })
      ],
    );
  }

}