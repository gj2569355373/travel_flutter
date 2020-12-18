// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerBin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBin _$CustomerBinFromJson(Map<String, dynamic> json) {
  return CustomerBin(
      json['id'] as String,
      json['name'] as String,
      json['telephone'] as String,
      json['address'] as String,
      json['openingBank'] as String,
      json['accountNumber'] as String);
}

Map<String, dynamic> _$CustomerBinToJson(CustomerBin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'telephone': instance.telephone,
      'address': instance.address,
      'openingBank': instance.openingBank,
      'accountNumber': instance.accountNumber
    };
