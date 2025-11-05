import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/banner_cms_model.dart';
import 'package:sprint3_app/models/dto/dto_protocol.dart';
import 'package:sprint3_app/models/sqlite/banner_sqlite_model.dart';

class BannerDTO extends Equatable
    implements DtoProtocol<BannerSqliteModel> {

  final String title;
  final String subtitle;
  final String description;
  final String? logoUrl;
  final bool isActive;

  const BannerDTO({
    this.title = 'Untitled',
    this.subtitle = 'No Subtitle',
    this.description = 'No description',
    this.logoUrl,
    this.isActive = false,
  });

  factory BannerDTO.fromCMS(BannerCMSModel? cmsModel) {
    if (cmsModel == null) {
      return BannerDTO();
    }

    final String title = cmsModel.title ?? 'Untitled';
    final String subtitle = cmsModel.subtitle ?? 'No Subtitle';
    final String description = cmsModel.description ?? 'No description';
    final String? logoUrl = cmsModel.logoUrl;
    final bool isActive = cmsModel.isActive ?? false;

    return BannerDTO(
      title: title,
      subtitle: subtitle,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive,
    );
  }

  BannerCMSModel toCMS() {
    return BannerCMSModel(
      title: title,
      subtitle: subtitle,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive,
    );
  }

  factory BannerDTO.fromSqlite(BannerSqliteModel? sqliteModel) {
    if (sqliteModel == null) {
      return BannerDTO();
    }

    return BannerDTO(
      title: sqliteModel.title,
      subtitle: sqliteModel.subtitle,
      description: sqliteModel.description,
      logoUrl: sqliteModel.logoUrl,
      isActive: sqliteModel.isActive
    );
  }

  @override
  BannerSqliteModel toSqlite() {
    return BannerSqliteModel(
      title: title,
      subtitle: subtitle,
      description: description,
      logoUrl: logoUrl,
      isActive: isActive
    );
  }

  static List<BannerDTO> getActiveBanners(List<BannerDTO> banners) {
    return banners.where((element) => element.isActive).toList();
  }

  @override
  List<Object?> get props => [title, subtitle, description, logoUrl, isActive];
}
