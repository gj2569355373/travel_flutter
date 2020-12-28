/*
 * create by gj
 * Created in 2020/12/28 10:39 上午
 * description: 忘记密码页面
 * */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/view/indicator_view.dart';
import 'package:travel_flutter/view/rounded_button.dart';
import 'package:travel_flutter/view/rounded_input_field.dart';
import 'package:travel_flutter/view/rounded_password_field.dart';
import 'package:travel_flutter/view/verification_code.dart';

import '../../r.dart';
import 'forgetPassword_cubit.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext contexts) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) => ForgetPasswordCubit(),
        child: Material(
            child: Stack(
                children: [ForgetPasswordWidget(), IndicatorView<ForgetPasswordCubit>()])));
  }
}

class ForgetPasswordWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ForgetPasswordCubit>(context).init(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
              R.assetsImgSignupTop,
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            //返回按钮
            top: statusBarHeight,
            left: 0,
            child: InkWell(
              onTap: () =>
                  BlocProvider.of<ForgetPasswordCubit>(context).back(context),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 10, bottom: 10, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios,
                        size: 22, color: Theme.of(context).accentColor),
                    Text(Translations.of(context).text(Constant.login),
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).accentColor)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              R.assetsImgLoginBottom,
              width: size.width * 0.3,
            ),
          ),
          Container(
            height: size.height * 0.8,
//        color: Colors.grey,
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                SvgPicture.asset(
                  R.assetsImgSignup,
                  height: size.height * 0.35,
                ),
                RoundedInputField(
                  kPrimaryColor: Theme.of(context).accentColor,
                  hintText:
                      Translations.of(context).text(Constant.loginUserText),
                  onChanged: (value) =>
                      BlocProvider.of<ForgetPasswordCubit>(context).changName(value),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E6FF),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  width: size.width * 0.8,
                  child: VerificationCode<ForgetPasswordCubit>(
                      Translations.of(context).text(Constant.verificationCode),
                      Translations.of(context)
                          .text(Constant.verificationCodeInput),
                      Translations.of(context).text(Constant.countDown),
                      () => BlocProvider.of<ForgetPasswordCubit>(context).sendCode(context),
                      kPrimaryColor: Theme.of(context).accentColor,
                      onChanged: (String code) => BlocProvider.of<ForgetPasswordCubit>(context).changCode(code),),
                ),
                RoundedPasswordField(
                  kPrimaryColor: Theme.of(context).accentColor,
                  hintText:
                      Translations.of(context).text(Constant.loginPassWordText),
                  onChanged: (value) => BlocProvider.of<ForgetPasswordCubit>(context)
                      .changPassWord(value),
                ),
                RoundedButton(
                  color: Theme.of(context).accentColor,
                  text: Translations.of(context).text(Constant.changePassword),
                  press: () =>
                      BlocProvider.of<ForgetPasswordCubit>(context).changePassword(context),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
