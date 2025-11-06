import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/models/dao/article_dao.dart';
import 'package:sprint3_app/models/dao/banner_dao.dart';
import 'package:sprint3_app/models/dao/news_source_dao.dart';
import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/models/dto/banner_dto.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';

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

  Future<void> deleteAll() async {
    await Future.wait([
      newsSourceDao.deleteAll(),
      bannerDao.deleteAll(),
      articleDao.deleteWhere(where: _where, whereArgs: _whereArgs),
    ]);
  }
}
