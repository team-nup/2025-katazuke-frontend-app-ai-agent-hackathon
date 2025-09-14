import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import 'package:okataduke/core/database/database_helper.dart';
import 'package:okataduke/core/database/database_migration.dart';

class CandidateProductNameRepository {
  static Future<void> insertMultiple(List<CandidateProductName> candidates) async {
    final db = await DatabaseHelper.database;
    final batch = db.batch();

    for (final candidate in candidates) {
      batch.insert(
        DatabaseMigration.candidateProductNamesTable,
        candidate.toMap(),
      );
    }

    await batch.commit(noResult: true);
  }

  static Future<List<CandidateProductName>> findByValueSearchId(String valueSearchId) async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseMigration.candidateProductNamesTable,
      where: 'value_search_id = ?',
      whereArgs: [valueSearchId],
      orderBy: 'rank ASC',
    );

    return List.generate(maps.length, (i) {
      return CandidateProductName.fromMap(maps[i]);
    });
  }

  static Future<void> deleteByValueSearchId(String valueSearchId) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      DatabaseMigration.candidateProductNamesTable,
      where: 'value_search_id = ?',
      whereArgs: [valueSearchId],
    );
  }
}