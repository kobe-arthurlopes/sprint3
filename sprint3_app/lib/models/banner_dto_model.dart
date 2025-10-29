import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/banner_cms_model.dart';

class BannerDTOModel extends Equatable {
  final String title;
  final String description;
  final String? logoUrl;
  final bool isActive;

  const BannerDTOModel({
    this.title = 'Untitled',
    this.description = 'No description',
    this.logoUrl,
    this.isActive = false
  });

  factory BannerDTOModel.fromCMS(BannerCMSModel? cmsModel) {
    if (cmsModel == null) {
      return BannerDTOModel();
    }

    final String title = cmsModel.title ?? 'Untitled';
    final String description = cmsModel.description ?? 'No description';
    final String? logoUrl = cmsModel.logoUrl;
    final bool isActive = cmsModel.isActive ?? false;

    return BannerDTOModel(
      title: title,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive
    );
  }

  BannerCMSModel toCMS() {
    return BannerCMSModel(
      title: title,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive
    );
  }

  @override
  List<Object?> get props => [title, description, logoUrl, isActive];
}