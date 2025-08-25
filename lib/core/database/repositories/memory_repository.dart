import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../models/shared/memory.dart';
import '../database_helper.dart';
import '../database_migration.dart';

class MemoryRepository {
  static const Uuid _uuid = Uuid();

  static Future<String> insert(Memory memory) async {
    try {
      final db = await DatabaseHelper.database;
      final now = DateTime.now();
      
      final memoryWithId = memory.copyWith(
        id: memory.id.isEmpty ? _uuid.v4() : memory.id,
        insertedAt: now,
        updatedAt: now,
      );
      
      await db.insert(
        DatabaseMigration.memoriesTable,
        memoryWithId.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      
      debugPrint('Memory inserted with ID: ${memoryWithId.id}');
      return memoryWithId.id;
    } catch (e) {
      debugPrint('Error inserting memory: $e');
      rethrow;
    }
  }

  static Future<Memory?> findById(String id) async {
    try {
      final db = await DatabaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseMigration.memoriesTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Memory.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      debugPrint('Error finding memory by ID: $e');
      rethrow;
    }
  }

  static Future<List<Memory>> findAll({
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await DatabaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseMigration.memoriesTable,
        orderBy: 'inserted_at DESC',
        limit: limit,
        offset: offset,
      );

      return List.generate(maps.length, (i) {
        return Memory.fromMap(maps[i]);
      });
    } catch (e) {
      debugPrint('Error finding all memories: $e');
      rethrow;
    }
  }

  static Future<int> update(Memory memory) async {
    try {
      final db = await DatabaseHelper.database;
      final updatedMemory = memory.copyWith(
        updatedAt: DateTime.now(),
      );

      final count = await db.update(
        DatabaseMigration.memoriesTable,
        updatedMemory.toMap(),
        where: 'id = ?',
        whereArgs: [memory.id],
      );
      
      debugPrint('Memory updated: ${memory.id}');
      return count;
    } catch (e) {
      debugPrint('Error updating memory: $e');
      rethrow;
    }
  }

  static Future<int> delete(String id) async {
    try {
      final db = await DatabaseHelper.database;
      final count = await db.delete(
        DatabaseMigration.memoriesTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      
      debugPrint('Memory deleted: $id');
      return count;
    } catch (e) {
      debugPrint('Error deleting memory: $e');
      rethrow;
    }
  }

  static Future<int> count() async {
    try {
      final db = await DatabaseHelper.database;
      final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseMigration.memoriesTable}',
      );
      return result.first['count'] as int;
    } catch (e) {
      debugPrint('Error counting memories: $e');
      rethrow;
    }
  }

  static Future<List<Memory>> getRecentMemories({int limit = 3}) async {
    try {
      return await findAll(limit: limit);
    } catch (e) {
      debugPrint('Error getting recent memories: $e');
      rethrow;
    }
  }

  static Future<Map<String, int>> getStatistics() async {
    try {
      final db = await DatabaseHelper.database;
      final List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT 
          status,
          COUNT(*) as count
        FROM ${DatabaseMigration.memoriesTable}
        GROUP BY status
      ''');

      final statistics = <String, int>{
        'total': 0,
        'keeping': 0,
        'considering': 0,
        'disposed': 0,
      };

      for (final row in result) {
        final status = row['status'] as String;
        final count = row['count'] as int;
        statistics[status] = count;
        statistics['total'] = statistics['total']! + count;
      }

      return statistics;
    } catch (e) {
      debugPrint('Error getting memory statistics: $e');
      rethrow;
    }
  }
}