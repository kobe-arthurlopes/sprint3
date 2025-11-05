import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/models/dao/article_dao_model.dart';
import 'package:sprint3_app/models/dao/banner_dao_model.dart';
import 'package:sprint3_app/models/dao/news_source_dao_model.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';

class HomeLocalDataSource {
  final NewsSourceDAOModel newsSourceDao;
  final BannerDAOModel bannerDao;
  final ArticleDAOModel articleDao;

  HomeLocalDataSource({
    required this.newsSourceDao,
    required this.bannerDao,
    required this.articleDao,
  });

  Future<HomeData> fetch() async {
    final newsSourcesSqlite = await newsSourceDao.fetchAll();
    final bannersSqlite = await bannerDao.fetchAll();

    final articlesSqlite = await articleDao.fetchWhere(
      where: 'category = ?',
      whereArgs: ['general'],
    );

    return HomeData(
      newsSources: newsSourcesSqlite
          .map(NewsSourceDTOModel.fromSqlite)
          .toList(),
      banners: bannersSqlite.map(BannerDTOModel.fromSqlite).toList(),
      articles: articlesSqlite.map(ArticleDTOModel.fromSqlite).toList(),
    );
  }

  Future<void> clearAll() async {
    await Future.wait([
      newsSourceDao.clear(),
      bannerDao.clear(),
      articleDao.clear(),
    ]);
  }
}
