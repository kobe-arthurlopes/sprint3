import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/common/models/dao/article_dao.dart';
import 'package:sprint3_app/common/models/dao/banner_dao.dart';
import 'package:sprint3_app/common/models/dao/news_source_dao.dart';
import 'package:sprint3_app/common/models/dto/article_dto.dart';
import 'package:sprint3_app/common/models/dto/banner_dto.dart';
import 'package:sprint3_app/common/models/dto/news_source_dto.dart';

class HomeLocalDataSource {
  final NewsSourceDAO newsSourceDao;
  final BannerDAO bannerDao;
  final ArticleDAO articleDao;

  HomeLocalDataSource({
    required this.newsSourceDao,
    required this.bannerDao,
    required this.articleDao,
  });

  final String _where = 'category = ?';
  final List<Object?> _whereArgs = ['general'];

  Future<HomeData> fetch() async {
    final newsSourcesSqlite = await newsSourceDao.fetchAll();
    final newsSources = newsSourcesSqlite
        .map((element) => NewsSourceDTO.fromSqlite(element))
        .toList();

    final bannersSqlite = await bannerDao.fetchAll();
    final banners = bannersSqlite
        .map((element) => BannerDTO.fromSqlite(element))
        .toList();

    final articlesSqlite = await articleDao.fetchWhere(
      where: _where,
      whereArgs: _whereArgs,
    );

    final articles = articlesSqlite
        .map((element) => ArticleDTO.fromSqlite(element))
        .toList();

    return HomeData(
      newsSources: newsSources,
      banners: banners,
      articles: articles,
    );
  }

  Future<void> deleteAll({required bool includingChildren}) async {
    await newsSourceDao.deleteAll();
    await bannerDao.deleteAll();
    
    if (includingChildren) {
      await articleDao.deleteAll();
    } else {
      await articleDao.deleteWhere(where: _where, whereArgs: _whereArgs);
    }
  }
}
