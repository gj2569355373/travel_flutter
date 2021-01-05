import 'dart:async';


import 'package:flutter/material.dart';

//修改密码和重置密码
class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseState();
  }
}

class BaseState extends State<ChangePasswordPage> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();
//  ChangePasswordPresenter changePasswordPresenter;
  Timer _timer;
  int _seconds;
  String labelText="lo";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("修改密码"),
      ),
      body: SingleChildScrollView(child:Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 15),
              height: 50,
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 6, right: 6),
              child: getRow("昵称", 2,
                  controller: phoneController,
                  hint: "hint")),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 26, right: 26, bottom: 16),
            child: getRowInputBotton(
                "129",
                "12",
                codeController,(labelText=="12"
                ||labelText=="12"),

                onTap: onTap,clickColor: Theme.of(context).accentColor),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 16,top: 80),
            child: new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              splashColor: Colors.deepPurple,
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.all(0.0),
              textColor: Colors.white,
              child: Container(
                child: new Text("提交", style: TextStyle(fontSize: 16)),
                width: 500,
                height: 45,
                alignment: Alignment.center,
              ),
              onPressed: () {
                // 登录
                print('确认');
//                print(userController.text + passController.text);
              },
            ),
          )

        ],
      ),)
    );
  }

  onTap() {
//    print('获取验证码');
    _startTimer();
  }
  _startTimer() {
    if(_timer!=null)
      return;
    _seconds = 10;
    labelText = "121";
    setState(() {});
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      labelText = "s";
      if (_seconds == 0) {
        labelText ="fasong";
      }
      setState(() {});
    });
  }

  _cancelTimer() {
    _timer?.cancel();
    _timer=null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();//countDown
//    changePasswordPresenter= BlocProvider.of<ChangePasswordPresenter>(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    initState之后调用，可在里面操作context;
    print('didChangeDependencies');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cancelTimer();
    super.dispose();
  }

  Widget getRowInputBotton(
      String buttonText, String hintText, TextEditingController controller,bool click,
      {onTap(),clickColor=Colors.deepOrange,noClickColor=Colors.grey}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: getInput(controller, hintText,textAlign: TextAlign.left),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 10),
          ),
          flex: 1,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.all(0),
          onPressed: onTap,
          color:click? clickColor:noClickColor,
          textColor: click?Colors.white:Colors.white70,
          splashColor: Colors.deepPurple,
          child: Container(
            margin: EdgeInsets.all(0),
            child: Text(buttonText,style: TextStyle(fontSize: 15),),
            width: 160,
            alignment: Alignment.center,
          ),
        )
      ],
    );
  }
  Widget getRow(String text, int type,
      {onTap(String value),
        List<String> list,
        String hint,
        controller,
        v,
        StateSetter state}) {
    return Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              padding: EdgeInsets.only(right: 20),
              child: Text(text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 2.0,
                  heightFactor: type == 1 ? 1.0 : 1.5,
                  child: getTypeWidget(type,
                      onTap: onTap,
                      list: list,
                      hint: hint,
                      controller: controller,
                      v: v,
                      state: state)),
              flex: 1,
            )
          ],
        ),
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 0));
  }

  Widget getTypeWidget(int type,
      {controller,
        v,
        onTap(String value),
        List<String> list,
        String hint,
        StateSetter state}) {
    if (type == 1) //返回下拉框
      return getDropdownButton(state, v, list, onTap);
    else if (type == 2) //返回输入框
      return getInput(controller, hint, onTap: onTap);
  }

  Widget getDropdownButton(
      StateSetter state, String v, List<String> list, onTap(String value),{String hint:'请选择'}) {
    return DropdownButton<String>(
        hint: new Text(hint, style: TextStyle(fontSize: 13)),
        value: v,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              child: Text(
                value,
                style: TextStyle(fontSize: 13),
              ),
              value: value);
        }).toList(),
        onChanged: (String value) {
          state(() {
            onTap(value);
          });
        });
  }

  Widget getInput(TextEditingController controller, String hint,
      {onTap(String value), textAlign = TextAlign.right,
        TextStyle labelStyle = const TextStyle(fontSize: 14)}) {
    return TextField(
      maxLines: 1,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 20),
        labelText: hint,
        labelStyle: labelStyle,
      ),
      onChanged: onTap,
      autofocus: false,
    );
  }
}
