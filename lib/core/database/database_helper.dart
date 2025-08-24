import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'database_migration.dart';

class DatabaseHelper {
  static const String _databaseName = 'okataduke.db';
  static const int _databaseVersion = 1;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    
    debugPrint('Database path: $path');
    
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: DatabaseMigration.onCreate,
      onUpgrade: DatabaseMigration.onUpgrade,
    );
  }

  static Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  static Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      debugPrint('Database deleted: $path');
    }
    
    _database = null;
  }
}