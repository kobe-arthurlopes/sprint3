import 'package:sprint3_app/common/models/dao/dao_protocol.dart';
import 'package:sprint3_app/common/models/sqlite/banner_sqlite_model.dart';

class BannerDAO extends DaoProtocol<BannerSqliteModel> {
  BannerDAO({required super.dbProvider})
    : super(model: BannerSqliteModel());
}