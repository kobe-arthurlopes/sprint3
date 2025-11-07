abstract class SqliteProtocol<T> {
  String get table;
  String get createTableQuery;
  Map<String, Object?> toSqliteMap();
  T toSqliteModel(Map<String, Object?> map);
}