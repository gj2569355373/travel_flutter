// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeItem _$TypeItemFromJson(Map<String, dynamic> json) {
  return TypeItem(json['title'], json['image'] as String, json['type'] as int,
      json['urlPage']);
}

Map<String, dynamic> _$TypeItemToJson(TypeItem instance) => <String, dynamic>{
      'urlPage': instance.urlPage,
      'title': instance.title,
      'image': instance.image,
      'type': instance.type
    };
