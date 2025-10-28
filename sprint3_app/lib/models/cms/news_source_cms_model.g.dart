// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceCMSModel _$NewsSourceCMSModelFromJson(Map<String, dynamic> json) =>
    NewsSourceCMSModel(
      sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      fields: NewsSourceCMSModelFields.fromJson(
        json['fields'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$NewsSourceCMSModelToJson(NewsSourceCMSModel instance) =>
    <String, dynamic>{'sys': instance.sys, 'fields': instance.fields};

NewsSourceCMSModelFields _$NewsSourceCMSModelFieldsFromJson(
  Map<String, dynamic> json,
) => NewsSourceCMSModelFields(
  name: json['name'] as String?,
  logoUrl: json['logoUrl'] as String?,
  sourceId: json['sourceId'] as String?,
);

Map<String, dynamic> _$NewsSourceCMSModelFieldsToJson(
  NewsSourceCMSModelFields instance,
) => <String, dynamic>{
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'sourceId': instance.sourceId,
};
