import 'package:json_annotation/json_annotation.dart';

import 'typeInterface.dart';
part 'panelBin.g.dart';

@JsonSerializable(nullable: false)
class PanelBin extends TypeGoto{
  int styleType;//样式类型
  String count;

  PanelBin(this.styleType, title,
      this.count,urlPage) : super(urlPage,title); //通过flutter pub run build_runner build在项目根目录中运行



  factory PanelBin.fromJson(Map<String, dynamic> json) => _$PanelBinFromJson(json);


  Map<String, dynamic> toJson() => _$PanelBinToJson(this);
}