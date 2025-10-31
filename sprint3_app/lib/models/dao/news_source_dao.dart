import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/sqlite/news_source_sqlite_model.dart';

class NewsSourceDao extends DaoProtocol<NewsSourceSqliteModel> {
  NewsSourceDao({required super.dbProvider})
    : super(model: NewsSourceSqliteModel());
}