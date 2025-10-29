import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_source_cms_model.g.dart';

@JsonSerializable()
class NewsSourceCMSModel extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? sourceId;
  static String contentType = 'newsSource';

  const NewsSourceCMSModel({
    this.name,
    this.logoUrl,
    this.sourceId
  });

  static NewsSourceCMSModel fromJson(Map<String, dynamic> json) {
    final String? jsonName = json['name'] as String?;
    final String? jsonLogoUrl = json['logo'] == null
        ? null
        : json['logo']['url'] as String;

    final String? sourceId = json['sourceId'] as String?;

    return NewsSourceCMSModel(
      name: jsonName,
      logoUrl: jsonLogoUrl,
      sourceId: sourceId,
    );
  }

  Map<String, dynamic> toJson() => _$NewsSourceCMSModelToJson(this);

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}

// @JsonSerializable()
// class NewsSourceCMSModelFields extends Equatable {
//   final String? name;
//   final String? logoUrl;
//   final String? sourceId;
  
//   const NewsSourceCMSModelFields({this.name, this.logoUrl, this.sourceId}) : super();

//   static NewsSourceCMSModelFields fromJson(Map<String, dynamic> json) {
//     final String? jsonName = json['name'] as String?;
//     String? jsonLogoUrl = json['logo'] == null
//         ? null
//         : Asset.fromJson(json['logo']).fields?.file?.url;
//     jsonLogoUrl = jsonLogoUrl != null ? 'https:$jsonLogoUrl' : null;

//     final String? sourceId = json['sourceId'] as String?;

//     return NewsSourceCMSModelFields(
//       name: jsonName,
//       logoUrl: jsonLogoUrl,
//       sourceId: sourceId,
//     );
//   }

//   Map<String, dynamic> toJson() => _$NewsSourceCMSModelFieldsToJson(this);

//   @override
//   List<Object?> get props => [name, logoUrl, sourceId];
// }