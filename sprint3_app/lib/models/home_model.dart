import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint3_app/models/carousel_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel extends Entry<HomeModelFields> {
  HomeModel({
    required SystemFields sys,
    required HomeModelFields fields
  }) : super(sys: sys, fields: fields);

  static String contentType = 'home';

  static HomeModel fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class HomeModelFields extends Equatable {
  final CarouselModel? carouselModel;

  const HomeModelFields({this.carouselModel});

  static HomeModelFields fromJson(Map<String, dynamic> json) {
    return HomeModelFields(
      carouselModel: CarouselModel.fromJson(json['carousel'] as Map<String, dynamic>)
    );
  }

  Map<String, dynamic> toJson() => _$HomeModelFieldsToJson(this);

  @override
  List<Object?> get props => [carouselModel];
}