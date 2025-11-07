import 'package:sprint3_app/common/models/dao/dao_protocol.dart';
import 'package:sprint3_app/common/models/sqlite/article_sqlite_model.dart';

class ArticleDAO extends DaoProtocol<ArticleSqliteModel> {
  ArticleDAO({required super.dbProvider}) : super(model: ArticleSqliteModel());
}
