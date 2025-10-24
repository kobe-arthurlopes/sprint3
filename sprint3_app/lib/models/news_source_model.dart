import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_source_model.g.dart';

@JsonSerializable()
class NewsSourceModel extends Entry<NewsSourceModelFields> {
  NewsSourceModel({
    required SystemFields sys,
    required NewsSourceModelFields fields,
  }) : super(sys: sys, fields: fields);

  static String contentType = 'newsSource';

  static NewsSourceModel fromJson(Map<String, dynamic> json) => _$NewsSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceModelToJson(this);
}

@JsonSerializable()
class NewsSourceModelFields extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? sourceId;
  
  const NewsSourceModelFields({this.name, this.logoUrl, this.sourceId}) : super();

  static NewsSourceModelFields fromJson(Map<String, dynamic> json) {
    final String? jsonName = json['name'] as String?;
    final String? jsonLogoUrl = json['logo'] == null ? null : Asset.fromJson(json['logo']).fields?.file?.url;
    final String? sourceId = json['sourceId'] as String?;

    return NewsSourceModelFields(
      name: jsonName,
      logoUrl: 'https:${jsonLogoUrl!}',
      sourceId: sourceId
    );
  }

  Map<String, dynamic> toJson() => _$NewsSourceModelFieldsToJson(this);

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}