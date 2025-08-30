import 'package:flutter/foundation.dart';
import '../../models/DB/value_search.dart';
import '../database_helper.dart';
import '../database_migration.dart';

class ValueSearchRepository {
  static Future<String> insert(ValueSearch valueSearch) async {
    final db = await DatabaseHelper.database;

    debugPrint('Inserting ValueSearch: ${valueSearch.id}');

    await db.insert(
      DatabaseMigration.valueSearchTable,
      valueSearch.toMap(),
    );

    debugPrint('ValueSearch inserted successfully: ${valueSearch.id}');
    return valueSearch.id;
  }

  static Future<void> update(ValueSearch valueSearch) async {
    final db = await DatabaseHelper.database;

    debugPrint('Updating ValueSearch: ${valueSearch.id}');

    final count = await db.update(
      DatabaseMigration.valueSearchTable,
      valueSearch.toMap(),
      where: 'id = ?',
      whereArgs: [valueSearch.id],
    );

    if (count == 0) {
      throw Exception('ValueSearch not found: ${valueSearch.id}');
    }

    debugPrint('ValueSearch updated successfully: ${valueSearch.id}');
  }

  static Future<void> delete(String id) async {
    final db = await DatabaseHelper.database;

    debugPrint('Deleting ValueSearch: $id');

    final count = await db.delete(
      DatabaseMigration.valueSearchTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (count == 0) {
      throw Exception('ValueSearch not found: $id');
    }

    debugPrint('ValueSearch deleted successfully: $id');
  }

  static Future<ValueSearch?> findById(String id) async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseMigration.valueSearchTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return ValueSearch.fromMap(maps.first);
  }

  static Future<List<ValueSearch>> findAll({
    int? limit,
    int? offset,
    String? orderBy,
  }) async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseMigration.valueSearchTable,
      orderBy: orderBy ?? 'updated_at DESC',
      limit: limit,
      offset: offset,
    );

    return maps.map((map) => ValueSearch.fromMap(map)).toList();
  }

  static Future<int> count() async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseMigration.valueSearchTable}',
    );

    return result.first['count'] as int;
  }

  static Future<List<ValueSearch>> findWithPagination({
    required int offset,
    required int limit,
    String? orderBy,
  }) async {
    return findAll(
      offset: offset,
      limit: limit,
      orderBy: orderBy,
    );
  }
}
