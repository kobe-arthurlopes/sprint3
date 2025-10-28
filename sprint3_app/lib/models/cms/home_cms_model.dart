import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';

part 'home_cms_model.g.dart';

@JsonSerializable()
class HomeCMSModel extends Entry<HomeCMSModelFields> {
  HomeCMSModel({
    required SystemFields sys,
    required HomeCMSModelFields fields
  }) : super(sys: sys, fields: fields);

  static String contentType = 'home';

  static HomeCMSModel fromJson(Map<String, dynamic> json) => _$HomeCMSModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCMSModelToJson(this);
}

@JsonSerializable()
class HomeCMSModelFields extends Equatable {
  final CarouselCMSModel? carousel;
  final String? title;

  const HomeCMSModelFields({this.carousel, this.title});

  static HomeCMSModelFields fromJson(Map<String, dynamic> json) {
    return HomeCMSModelFields(
      title: json['title'] as String?,
      carousel: CarouselCMSModel.fromJson(json['carousel'] as Map<String, dynamic>)
    );
  }

  Map<String, dynamic> toJson() => _$HomeCMSModelFieldsToJson(this);

  @override
  List<Object?> get props => [carousel, title];
}