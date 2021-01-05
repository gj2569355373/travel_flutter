import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'res_index.dart';

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_normal,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
  );
  static TextStyle typeListTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colors.black,
  );
  static TextStyle typeListName = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_dark,
  );

  static TextStyle panelNumber = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.gray_f0,
  );
  static TextStyle panelName = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.gray_f0,
  );
  static TextStyle newOrderTitle = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.black,
  );
  static TextStyle newOrderText = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.app_main,
  );
  static TextStyle newOrderTitleWhite = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );
  static TextStyle contactsTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colors.black,
  );
  static TextStyle contactsNumber = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.blueAccent,
  );
  static TextStyle contactsLabel = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colors.grey,
  );
  static TextStyle contactsValue = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.black87,
  );
  static TextStyle hintStyle = TextStyle(fontSize: 14);

  static TextStyle rowLableNameStyle= TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black87,);
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Colours.divider)));
}
/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
}
