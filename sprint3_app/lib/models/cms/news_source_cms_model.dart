import 'package:sprint3_app/models/cms/cms_model.dart';

class NewsSourceCMSModel extends AutoRegisterCmsModel<NewsSourceCMSModel> {
  final String? name;
  final String? logoUrl;
  final String? sourceId;

  const NewsSourceCMSModel({this.name, this.logoUrl, this.sourceId}) : super();

  static final register = CmsModel.registerModel<NewsSourceCMSModel>(() => NewsSourceCMSModel());

  @override
  final String contentType = 'newsSource';

  @override
  String fieldsQuery() => '''
    name
    sourceId
    logo {
      url
    }
  ''';

  @override
  CmsModel fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'logoUrl': logoUrl,
    'sourceId': sourceId
  };

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}