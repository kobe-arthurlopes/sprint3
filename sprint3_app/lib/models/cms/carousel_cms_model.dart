import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

part 'carousel_cms_model.g.dart';

@JsonSerializable()
class CarouselCMSModel extends Entry<CarouselCMSModelFields> {
  CarouselCMSModel({
    required SystemFields sys,
    required CarouselCMSModelFields fields,
  }) : super(sys: sys, fields: fields);

  static String contentType = 'carouselNewsSources';

  static CarouselCMSModel fromJson(Map<String, dynamic> json) => _$CarouselCMSModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselCMSModelToJson(this);
}

@JsonSerializable()
class CarouselCMSModelFields extends Equatable {
  final List<NewsSourceCMSModel>? newsSources;

  const CarouselCMSModelFields({this.newsSources});

  static CarouselCMSModelFields fromJson(Map<String, dynamic> json) {
    final List<dynamic>? items = json['newsSources'] as List<dynamic>?;

    return CarouselCMSModelFields(
      newsSources: items?.map((item) => NewsSourceCMSModel.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$CarouselCMSModelFieldsToJson(this);

  @override
  List<Object?> get props => [newsSources];
}