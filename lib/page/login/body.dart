import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/r.dart';
import 'package:travel_flutter/view/already_have_an_account_acheck.dart';
import 'package:travel_flutter/view/or_divider.dart';
import 'package:travel_flutter/view/rounded_button.dart';
import 'package:travel_flutter/view/rounded_input_field.dart';
import 'package:travel_flutter/view/rounded_password_field.dart';
import 'package:travel_flutter/view/social_icon.dart';

import 'background.dart';
import 'login_cubit.dart';


class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            SizedBox(height: size.height * 0.01),
            SvgPicture.asset(
              R.assetsImgLogin,
              height: size.height * 0.35,
            ),
            RoundedInputField(
              kPrimaryColor: Theme.of(context).accentColor,
              hintText: Translations.of(context).text(Constant.loginUserText),
              onChanged: (value)=> BlocProvider.of<LoginCubit>(context).changName(value),
            ),
            RoundedPasswordField(
              kPrimaryColor: Theme.of(context).accentColor,
              hintText: Translations.of(context).text(Constant.loginPassWordText),
              onChanged: (value) =>BlocProvider.of<LoginCubit>(context).changPassWord(value),
            ),
            RoundedButton(
              color: Theme.of(context).accentColor,
              text: Translations.of(context).text(Constant.login),
              press: () =>BlocProvider.of<LoginCubit>(context).login(context),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  splashColor: Color(0x00ffffff),
                  highlightColor: Color(0x00ffffff),
                  child: Container(
                    width: 90,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Translations.of(context).text(Constant.forgetPassword),
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15),
                    ),
                  ),
                  onPressed: () =>BlocProvider.of<LoginCubit>(context).forgetPassword(context),
                ),
                FlatButton(
                  splashColor: Color(0x00ffffff),
                  highlightColor: Color(0x00ffffff),
                  child: Container(
                    width: 70,
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: Text(
                      Translations.of(context).text(Constant.register),
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15),
                    ),
                  ),
                  onPressed: () =>BlocProvider.of<LoginCubit>(context).register(context),
                )
              ],
            ),
            OrDivider( kPrimaryColor: Theme.of(context).accentColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: ()=>BlocProvider.of<LoginCubit>(context).wechat(context),
                  child: Image.asset(
                    R.assetsImgLoginWechat,
                    fit: BoxFit.contain,
                    width: size.height * 0.05,
                    height: size.height * 0.05,
                  ),
                ),
//                Container(),
                InkWell(
                  onTap: ()=>BlocProvider.of<LoginCubit>(context).instagram(context),
                  child: Image.asset(
                    R.assetsImgLoginInstagram,
                    fit: BoxFit.contain,
                    width: size.height * 0.05,
                    height: size.height * 0.05,
                  ),
                )
//                SocalIcon(
//                  iconSrc: R.assetsImgLoginWechat,
//                  press: () {},
//                ),
//                SocalIcon(
//                  iconSrc: R.assetsImgLoginInstagram,
//                  press: () {},
//                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
