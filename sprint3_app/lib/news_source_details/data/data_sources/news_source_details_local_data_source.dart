import 'package:sprint3_app/models/dao/article_dao_model.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';

class NewsSourceDetailsLocalDataSource {
  final ArticleDAOModel articleDao;
  String? sourceId;

  NewsSourceDetailsLocalDataSource({
    required this.articleDao,
    this.sourceId
  });

  Future<NewsSourceDetailsData> fetch() async {
    final articlesSqlite = await articleDao.fetchWhere(
      where: 'category IS NULL AND sourceId = ?', 
      whereArgs: [sourceId]
    );

    return NewsSourceDetailsData(
      articles: articlesSqlite.map(ArticleDTOModel.fromSqlite).toList()
    );
  }
}