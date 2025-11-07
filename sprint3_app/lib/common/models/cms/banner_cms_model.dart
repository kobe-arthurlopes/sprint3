import 'package:sprint3_app/common/models/cms/cms_model.dart';

class BannerCMSModel extends AutoRegisterCmsModel<BannerCMSModel> {
  final String? title;
  final String? subtitle;
  final String? description;
  final String? logoUrl;
  final bool? isActive;

  const BannerCMSModel({
    this.title,
    this.subtitle,
    this.description,
    this.logoUrl,
    this.isActive,
  });

  static final register = CmsModelProtocol.registerModel<BannerCMSModel>(
    () => BannerCMSModel(),
  );

  @override
  final String contentType = 'banner';

  @override
  String fieldsQuery() {
    return '''
      title
      subtitle
      description
      image {
        url
      }
      isActive
    ''';
  }

  @override
  CmsModelProtocol fromJson(Map<String, dynamic> json) {
    final String? jsonTitle = json['title'] as String?;
    final String? subtitle = json['subtitle'] as String?;
    final String? jsonDescription = json['description'] as String?;
    final String? jsonLogoUrl = json['image'] == null
        ? null
        : json['image']['url'] as String;
    final bool? jsonIsActive = json['isActive'];

    return BannerCMSModel(
      title: jsonTitle,
      subtitle: subtitle,
      description: jsonDescription,
      logoUrl: jsonLogoUrl,
      isActive: jsonIsActive,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'description': description,
    'logoUrl': logoUrl,
    'isActive': isActive,
  };

  @override
  List<Object?> get props => [title, subtitle, description, logoUrl, isActive];
}
