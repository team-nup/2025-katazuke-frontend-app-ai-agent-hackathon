import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMigration {
  static const String memoriesTable = 'memories';

  static Future<void> onCreate(Database db, int version) async {
    debugPrint('Creating database tables...');
    
    await _createMemoriesTable(db);
    
    debugPrint('Database tables created successfully');
  }

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Upgrading database from version $oldVersion to $newVersion');
    
    for (int version = oldVersion + 1; version <= newVersion; version++) {
      await _migrateToVersion(db, version);
    }
  }

  static Future<void> _createMemoriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $memoriesTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        detail TEXT,
        start_age INTEGER,
        end_age INTEGER,
        image_paths TEXT,
        status TEXT DEFAULT 'keeping',
        disposed_at INTEGER,
        inserted_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _migrateToVersion(Database db, int version) async {
    switch (version) {
      case 1:
        // 初期バージョンなので何もしない
        break;
      // 将来のマイグレーションをここに追加
      // case 2:
      //   await _migrateToVersion2(db);
      //   break;
      default:
        debugPrint('Unknown database version: $version');
    }
  }

  // 将来のマイグレーション例
  // static Future<void> _migrateToVersion2(Database db) async {
  //   await db.execute('ALTER TABLE $memoriesTable ADD COLUMN new_column TEXT');
  // }
}