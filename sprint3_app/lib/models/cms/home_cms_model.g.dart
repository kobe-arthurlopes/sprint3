// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCMSModel _$HomeCMSModelFromJson(Map<String, dynamic> json) => HomeCMSModel(
  sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
  fields: HomeCMSModelFields.fromJson(json['fields'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeCMSModelToJson(HomeCMSModel instance) =>
    <String, dynamic>{'sys': instance.sys, 'fields': instance.fields};

HomeCMSModelFields _$HomeCMSModelFieldsFromJson(Map<String, dynamic> json) =>
    HomeCMSModelFields(
      carousel: json['carousel'] == null
          ? null
          : CarouselCMSModel.fromJson(json['carousel'] as Map<String, dynamic>),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$HomeCMSModelFieldsToJson(HomeCMSModelFields instance) =>
    <String, dynamic>{'carousel': instance.carousel, 'title': instance.title};
