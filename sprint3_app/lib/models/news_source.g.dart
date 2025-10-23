// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSource _$NewsSourceFromJson(Map<String, dynamic> json) => NewsSource(
  sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
  fields: NewsSourceFields.fromJson(json['fields'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NewsSourceToJson(NewsSource instance) =>
    <String, dynamic>{'sys': instance.sys, 'fields': instance.fields};

NewsSourceFields _$NewsSourceFieldsFromJson(Map<String, dynamic> json) =>
    NewsSourceFields(
      name: json['name'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$NewsSourceFieldsToJson(NewsSourceFields instance) =>
    <String, dynamic>{'name': instance.name, 'logoUrl': instance.logoUrl};
