import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_source_cms_model.g.dart';

@JsonSerializable()
class NewsSourceCMSModel extends Entry<NewsSourceCMSModelFields> {
  NewsSourceCMSModel({
    required SystemFields sys,
    required NewsSourceCMSModelFields fields,
  }) : super(sys: sys, fields: fields);

  static String contentType = 'newsSource';

  static NewsSourceCMSModel fromJson(Map<String, dynamic> json) => _$NewsSourceCMSModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceCMSModelToJson(this);
}

@JsonSerializable()
class NewsSourceCMSModelFields extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? sourceId;
  
  const NewsSourceCMSModelFields({this.name, this.logoUrl, this.sourceId}) : super();

  static NewsSourceCMSModelFields fromJson(Map<String, dynamic> json) {
    final String? jsonName = json['name'] as String?;
    final String? jsonLogoUrl = json['logo'] == null ? null : Asset.fromJson(json['logo']).fields?.file?.url;
    final String? sourceId = json['sourceId'] as String?;

    return NewsSourceCMSModelFields(
      name: jsonName,
      logoUrl: 'https:${jsonLogoUrl!}',
      sourceId: sourceId
    );
  }

  Map<String, dynamic> toJson() => _$NewsSourceCMSModelFieldsToJson(this);

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}