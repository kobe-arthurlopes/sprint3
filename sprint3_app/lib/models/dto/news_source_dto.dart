import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';
import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/models/dto/dto_protocol.dart';
import 'package:sprint3_app/models/sqlite/news_source_sqlite_model.dart';

class NewsSourceDTO extends Equatable
    implements DtoProtocol<NewsSourceSqliteModel> {

  final String name;
  final String? logoUrl;
  final String? sourceId;
  final bool isActive;
  final List<ArticleDTO> articles;

  NewsSourceDTO({
    required this.name,
    this.logoUrl,
    this.sourceId,
    this.isActive = false,
    List<ArticleDTO>? articles,
  }) : articles = articles ?? [];

  factory NewsSourceDTO.fromCMS(NewsSourceCMSModel? cmsModel) {
    if (cmsModel == null) {
      return NewsSourceDTO(name: 'Untitled');
    }

    final String name = cmsModel.name ?? 'Untitled';
    final String? logoUrl = cmsModel.logoUrl;
    final String? sourceId = cmsModel.sourceId;
    final bool isActive = cmsModel.isActive ?? false;

    return NewsSourceDTO(
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

  factory NewsSourceDTO.fromSqlite(NewsSourceSqliteModel? sqliteModel) {
    if (sqliteModel == null) {
      return NewsSourceDTO(name: 'Untitled');
    }

    return NewsSourceDTO(
      name: sqliteModel.name,
      logoUrl: sqliteModel.logoUrl,
      sourceId: sqliteModel.sourceId,
      isActive: sqliteModel.isActive
    );
  }

  @override
  NewsSourceSqliteModel toSqlite() {
    return NewsSourceSqliteModel(
      name: name,
      logoUrl: logoUrl,
      sourceId: sourceId,
      isActive: isActive
    );
  }

  static List<NewsSourceDTO> getActiveNewsSources(
    List<NewsSourceDTO> newsSources,
  ) {
    return newsSources.where((element) => element.isActive).toList();
  }

  @override
  List<Object?> get props => [name, logoUrl, sourceId, isActive];
}
