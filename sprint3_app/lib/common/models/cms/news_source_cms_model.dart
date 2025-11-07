import 'package:sprint3_app/common/models/cms/cms_model.dart';

class NewsSourceCMSModel extends AutoRegisterCmsModel<NewsSourceCMSModel> {
  final String? name;
  final String? logoUrl;
  final String? sourceId;
  final bool? isActive;

  const NewsSourceCMSModel({
    this.name,
    this.logoUrl,
    this.sourceId,
    this.isActive,
  }) : super();

  static final register = CmsModelProtocol.registerModel<NewsSourceCMSModel>(
    () => NewsSourceCMSModel(),
  );

  @override
  final String contentType = 'newsSource';

  @override
  String fieldsQuery() => '''
    name
    sourceId
    logo {
      url
    }
    isActive
  ''';

  @override
  CmsModelProtocol fromJson(Map<String, dynamic> json) {
    final String? jsonName = json['name'] as String?;
    final String? jsonLogoUrl = json['logo'] == null
        ? null
        : json['logo']['url'] as String;

    final String? sourceId = json['sourceId'] as String?;
    final bool? isActive = json['isActive'] as bool?;

    return NewsSourceCMSModel(
      name: jsonName,
      logoUrl: jsonLogoUrl,
      sourceId: sourceId,
      isActive: isActive
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'logoUrl': logoUrl,
    'sourceId': sourceId,
    'isActive': isActive
  };

  @override
  List<Object?> get props => [name, logoUrl, sourceId, isActive];
}
