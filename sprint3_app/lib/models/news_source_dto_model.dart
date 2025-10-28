import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

class NewsSourceDTOModel extends Equatable {
  final String name;
  final String? logoUrl;
  final String? sourceId;

  const NewsSourceDTOModel({
    required this.name,
    this.logoUrl,
    this.sourceId
  });

  factory NewsSourceDTOModel.fromCMS(NewsSourceCMSModel? cmsModel) {
    if (cmsModel == null) {
      return NewsSourceDTOModel(name: 'Untitled');
    }

    final String name = cmsModel.fields?.name ?? 'Untitled';
    final String? logoUrl = cmsModel.fields?.logoUrl;
    final String? sourceId = cmsModel.fields?.sourceId;

    return NewsSourceDTOModel(
      name: name,
      logoUrl: logoUrl,
      sourceId: sourceId
    );
  }

  NewsSourceCMSModel toCMS() {
    return NewsSourceCMSModel(
      sys: SystemFields(id: '', type: 'Entry'), 
      fields: NewsSourceCMSModelFields(
        name: name,
        logoUrl: logoUrl,
        sourceId: sourceId
      )
    );
  }

  @override
  List<Object?> get props => [name, logoUrl, sourceId];
}