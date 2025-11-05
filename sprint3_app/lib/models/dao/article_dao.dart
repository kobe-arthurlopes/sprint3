import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';

class ArticleDAO extends DaoProtocol<ArticleSqliteModel> {
  ArticleDAO({required super.dbProvider})
    : super(model: ArticleSqliteModel());
}