import 'package:flutter/material.dart';
import 'package:travel_flutter/res/styles.dart';

import 'text_field_container.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final  Color kPrimaryColor;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,this.kPrimaryColor=const Color(0xFF6F35A5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.hintStyle,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
