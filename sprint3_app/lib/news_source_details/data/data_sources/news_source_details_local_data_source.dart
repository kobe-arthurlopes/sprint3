import 'package:sprint3_app/models/dao/article_dao.dart';
import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';

class NewsSourceDetailsLocalDataSource {
  final ArticleDAO articleDao;
  String? sourceId;

  NewsSourceDetailsLocalDataSource({required this.articleDao, this.sourceId});

  Future<NewsSourceDetailsData> fetch() async {
    final articlesSqlite = await articleDao.fetchWhere(
      where: 'category IS NULL AND sourceId = ?',
      whereArgs: [sourceId],
    );

    final articles = articlesSqlite
        .map((element) => ArticleDTO.fromSqlite(element))
        .toList();

    return NewsSourceDetailsData(articles: articles);
  }
}
