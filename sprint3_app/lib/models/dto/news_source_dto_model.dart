import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';
import 'package:sprint3_app/models/sqlite/news_source_sqlite_model.dart';

class NewsSourceDTOModel extends Equatable {
  final String name;
  final String? logoUrl;
  final String? sourceId;
  final bool isActive;

  const NewsSourceDTOModel({
    required this.name,
    this.logoUrl,
    this.sourceId,
    this.isActive = false,
  });

  factory NewsSourceDTOModel.fromCMS(NewsSourceCMSModel? cmsModel) {
    if (cmsModel == null) {
      return NewsSourceDTOModel(name: 'Untitled');
    }

    final String name = cmsModel.name ?? 'Untitled';
    final String? logoUrl = cmsModel.logoUrl;
    final String? sourceId = cmsModel.sourceId;
    final bool isActive = cmsModel.isActive ?? false;

    return NewsSourceDTOModel(
      name: name,
      logoUrl: logoUrl,
      sourceId: sourceId,
      isActive: isActive,
    );
  }

  NewsSourceCMSModel toCMS() {
    return NewsSourceCMSModel(
      name: name,
      logoUrl: logoUrl,
      sourceId: sourceId,
      isActive: isActive,
    );
  }

  factory NewsSourceDTOModel.fromSqlite(NewsSourceSqliteModel? sqliteModel) {
    if (sqliteModel == null) {
      return NewsSourceDTOModel(name: 'Untitled');
    }

    return NewsSourceDTOModel(
      name: sqliteModel.name,
      logoUrl: sqliteModel.logoUrl,
      sourceId: sqliteModel.sourceId,
      isActive: sqliteModel.isActive
    );
  }

  NewsSourceSqliteModel toSqlite() {
    return NewsSourceSqliteModel(
      name: name,
      logoUrl: logoUrl,
      sourceId: sourceId,
      isActive: isActive
    );
  }

  static List<NewsSourceDTOModel> getActiveNewsSources(
    List<NewsSourceDTOModel> newsSources,
  ) {
    return newsSources.where((element) => element.isActive).toList();
  }

  @override
  List<Object?> get props => [name, logoUrl, sourceId, isActive];
}
