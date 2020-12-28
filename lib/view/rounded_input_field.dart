import 'package:flutter/material.dart';
import 'package:travel_flutter/res/styles.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final  Color kPrimaryColor;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,this.kPrimaryColor=const Color(0xFF6F35A5)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyles.hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
