import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';

part 'home_cms_model.g.dart';

@JsonSerializable()
class HomeCMSModel extends Equatable {
  final String? title;
  final CarouselCMSModel? carousel;
  static String contentType = 'home';

  const HomeCMSModel({this.title, this.carousel});

  factory HomeCMSModel.fromJson(Map<String, dynamic> json) {
    return HomeCMSModel(
      title: json['title'] as String?,
      carousel: json['carousel'] == null
          ? null
          : CarouselCMSModel.fromJson(json['carousel'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => _$HomeCMSModelToJson(this);

  @override
  List<Object?> get props => [carousel, title];
}
