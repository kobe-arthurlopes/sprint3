import 'package:sprint3_app/common/models/dao/article_dao.dart';
import 'package:sprint3_app/common/models/dto/article_dto.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';

class NewsSourceDetailsLocalDataSource {
  final ArticleDAO articleDao;
  String? sourceId;

  NewsSourceDetailsLocalDataSource({required this.articleDao, this.sourceId});

  final String _where = 'category IS NULL AND sourceId = ?';

  Future<NewsSourceDetailsData> fetch() async {
    final articlesSqlite = await articleDao.fetchWhere(
      where: _where,
      whereArgs: [sourceId],
    );

    final articles = articlesSqlite
        .map((element) => ArticleDTO.fromSqlite(element))
        .toList();

    return NewsSourceDetailsData(articles: articles);
  }

  Future<void> deleteAll() async {
    await articleDao.deleteWhere(
      where: _where, 
      whereArgs: [sourceId]
    );
  }
}
