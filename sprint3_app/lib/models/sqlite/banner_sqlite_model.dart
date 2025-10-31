import 'package:sprint3_app/models/sqlite/sqlite_model.dart';

class BannerSqliteModel implements SqliteModel<BannerSqliteModel> {
  final String title;
  final String subtitle;
  final String description;
  final String? logoUrl;
  final bool isActive;

  const BannerSqliteModel({
    this.title = 'Untitled',
    this.subtitle = 'No Subtitle',
    this.description = 'No description',
    this.logoUrl,
    this.isActive = false,
  });

  @override
  String get table => 'banners';

  @override
  String get createTableQuery => '''
    CREATE TABLE $table (
      title TEXT PRIMARY KEY,
      subtitle TEXT NOT NULL,
      description TEXT NOT NULL,
      logoUrl TEXT,
      isActive INTEGER NOT NULL
    );
 ''';

  @override
  Map<String, Object?> toSqliteMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'logoUrl': logoUrl,
      'isActive': isActive ? 1 : 0
    };
  }

  @override
  BannerSqliteModel toSqliteModel(Map<String, Object?> map) {
    return BannerSqliteModel(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
      logoUrl: map['logoUrl'] as String?,
      isActive: (map['isActive'] as int) == 1,
    );
  }
}