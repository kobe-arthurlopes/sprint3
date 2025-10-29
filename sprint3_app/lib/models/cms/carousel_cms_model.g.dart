// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselCMSModel _$CarouselCMSModelFromJson(Map<String, dynamic> json) =>
    CarouselCMSModel(
      newsSources: (json['newsSources'] as List<dynamic>?)
          ?.map((e) => NewsSourceCMSModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarouselCMSModelToJson(CarouselCMSModel instance) =>
    <String, dynamic>{'newsSources': instance.newsSources};
