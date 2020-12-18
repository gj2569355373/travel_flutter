import 'package:json_annotation/json_annotation.dart';
part 'customerBin.g.dart';
/*
* 企业配置信息
* 名称\logo\接口地址
* */
@JsonSerializable(nullable: false)
class CustomerBin{
  String id;
  String name;//
  String telephone;//
  String address;
  String openingBank;
  String accountNumber;


  CustomerBin(this.id, this.name, this.telephone, this.address,
      this.openingBank, this.accountNumber); //反序列化

  factory CustomerBin.fromJson(Map<String, dynamic> json) => _$CustomerBinFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CustomerBinToJson(this);
}