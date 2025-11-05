import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/sqlite/banner_sqlite_model.dart';

class BannerDAO extends DaoProtocol<BannerSqliteModel> {
  BannerDAO({required super.dbProvider})
    : super(model: BannerSqliteModel());
}