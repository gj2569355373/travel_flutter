import 'package:json_annotation/json_annotation.dart';
import 'typeInterface.dart';
part 'typeItem.g.dart';

@JsonSerializable(nullable: false)
class TypeItem extends TypeGoto{//nullable取消空验证
  String image;
  int type;//1.本地，2.外部url

  TypeItem(title, this.image, this.type, urlPage) : super(urlPage,title);

  //反序列化
  factory TypeItem.fromJson(Map<String, dynamic> json) => _$TypeItemFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TypeItemToJson(this);
}