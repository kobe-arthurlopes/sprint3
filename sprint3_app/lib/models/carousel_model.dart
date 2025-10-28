import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint3_app/models/news_source_model.dart';

part 'carousel_model.g.dart';

@JsonSerializable()
class CarouselModel extends Entry<CarouselModelFields> {
  CarouselModel({
    required SystemFields sys,
    required CarouselModelFields fields,
  }) : super(sys: sys, fields: fields);

  static String contentType = 'carouselNewsSources';

  static CarouselModel fromJson(Map<String, dynamic> json) => _$CarouselModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselModelToJson(this);
}

@JsonSerializable()
class CarouselModelFields extends Equatable {
  final List<NewsSourceModel>? newsSources;

  const CarouselModelFields({this.newsSources});

  static CarouselModelFields fromJson(Map<String, dynamic> json) {
    final List<dynamic>? items = json['newsSources'] as List<dynamic>?;

    return CarouselModelFields(
      newsSources: items?.map((item) => NewsSourceModel.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$CarouselModelFieldsToJson(this);

  @override
  List<Object?> get props => [newsSources];
}