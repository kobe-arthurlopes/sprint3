import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';

class ArticleDAOModel extends DaoProtocol<ArticleSqliteModel> {
  ArticleDAOModel({required super.dbProvider})
    : super(model: ArticleSqliteModel());
}