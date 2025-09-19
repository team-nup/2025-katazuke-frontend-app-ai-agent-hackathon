import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMigration {
  static const String memoriesTable = 'memories';
  static const String valueSearchTable = 'value_searches';
  static const String candidateProductNamesTable = 'candidate_product_names';

  static Future<void> onCreate(Database db, int version) async {
    debugPrint('Creating database tables...');

    await _createMemoriesTable(db);
    await _createValueSearchTable(db);
    await _createCandidateProductNamesTable(db);

    debugPrint('Database tables created successfully');
  }

  static Future<void> onUpgrade(
      Database db, int oldVersion, int newVersion) async {
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

    await db.execute('''
      CREATE INDEX idx_memories_status
      ON $memoriesTable (status)
    ''');

    await db.execute('''
      CREATE INDEX idx_memories_inserted_at
      ON $memoriesTable (inserted_at DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_memories_disposed_at
      ON $memoriesTable (disposed_at DESC)
    ''');
  }

  static Future<void> _createValueSearchTable(Database db) async {
    await db.execute('''
      CREATE TABLE $valueSearchTable (
        id TEXT PRIMARY KEY,
        product_name_hint TEXT,
        image_paths TEXT NOT NULL,
        value INTEGER,
        status TEXT DEFAULT 'keeping',
        detected_product_name TEXT NOT NULL,
        ai_confidence_score INTEGER NOT NULL,
        disposed_at INTEGER,
        inserted_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_value_searches_status
      ON $valueSearchTable (status)
    ''');

    await db.execute('''
      CREATE INDEX idx_value_searches_inserted_at
      ON $valueSearchTable (inserted_at DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_value_searches_disposed_at
      ON $valueSearchTable (disposed_at DESC)
    ''');
  }

  static Future<void> _createCandidateProductNamesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $candidateProductNamesTable (
        id TEXT PRIMARY KEY,
        value_search_id TEXT NOT NULL,
        rank INTEGER NOT NULL,
        product_name TEXT NOT NULL,
        confidence REAL NOT NULL,
        inserted_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (value_search_id) REFERENCES $valueSearchTable (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_candidate_product_names_value_search_id
      ON $candidateProductNamesTable (value_search_id)
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
