import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_source.g.dart';

@JsonSerializable()
class NewsSource extends Entry<NewsSourceFields> {
  NewsSource({
    required SystemFields sys,
    required NewsSourceFields fields,
  }) : super(sys: sys, fields: fields);

  static String contentType = 'newsSource';

  static NewsSource fromJson(Map<String, dynamic> json) => _$NewsSourceFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceToJson(this);
}

@JsonSerializable()
class NewsSourceFields extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? sourceId;
  
  const NewsSourceFields({this.name, this.logoUrl, this.sourceId}) : super();

  static NewsSourceFields fromJson(Map<String, dynamic> json) {
    final String? jsonName = json['name'] as String?;
    final String? jsonLogoUrl = json['logo'] == null ? null : Asset.fromJson(json['logo']).fields?.file?.url;
    final String? sourceId = json['sourceId'] as String?;

    return NewsSourceFields(
      name: jsonName,
      logoUrl: 'https:${jsonLogoUrl!}',
      sourceId: sourceId
    );
  }

  Map<String, dynamic> toJson() => _$NewsSourceFieldsToJson(this);

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}