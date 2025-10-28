// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselCMSModel _$CarouselCMSModelFromJson(Map<String, dynamic> json) =>
    CarouselCMSModel(
      sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      fields: CarouselCMSModelFields.fromJson(
        json['fields'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CarouselCMSModelToJson(CarouselCMSModel instance) =>
    <String, dynamic>{'sys': instance.sys, 'fields': instance.fields};

CarouselCMSModelFields _$CarouselCMSModelFieldsFromJson(
  Map<String, dynamic> json,
) => CarouselCMSModelFields(
  newsSources: (json['newsSources'] as List<dynamic>?)
      ?.map((e) => NewsSourceCMSModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CarouselCMSModelFieldsToJson(
  CarouselCMSModelFields instance,
) => <String, dynamic>{'newsSources': instance.newsSources};
