abstract class DtoProtocol<T> {
  factory DtoProtocol.fromSqlite(T sqliteModel) => throw UnimplementedError('Should be implemented by subclasses');

  T toSqlite();
}