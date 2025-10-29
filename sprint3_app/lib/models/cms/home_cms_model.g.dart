// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCMSModel _$HomeCMSModelFromJson(Map<String, dynamic> json) => HomeCMSModel(
  title: json['title'] as String?,
  carousel: json['carousel'] == null
      ? null
      : CarouselCMSModel.fromJson(json['carousel'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeCMSModelToJson(HomeCMSModel instance) =>
    <String, dynamic>{'title': instance.title, 'carousel': instance.carousel};
