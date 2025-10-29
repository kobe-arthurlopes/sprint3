// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceCMSModel _$NewsSourceCMSModelFromJson(Map<String, dynamic> json) =>
    NewsSourceCMSModel(
      name: json['name'] as String?,
      logoUrl: json['logoUrl'] as String?,
      sourceId: json['sourceId'] as String?,
    );

Map<String, dynamic> _$NewsSourceCMSModelToJson(NewsSourceCMSModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'sourceId': instance.sourceId,
    };
