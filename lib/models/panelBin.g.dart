// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panelBin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelBin _$PanelBinFromJson(Map<String, dynamic> json) {
  return PanelBin(json['styleType'] as int, json['title'],
      json['count'] as String, json['urlPage']);
}

Map<String, dynamic> _$PanelBinToJson(PanelBin instance) => <String, dynamic>{
      'urlPage': instance.urlPage,
      'title': instance.title,
      'styleType': instance.styleType,
      'count': instance.count
    };
