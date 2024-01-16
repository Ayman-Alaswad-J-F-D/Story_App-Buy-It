import 'package:sqflite/sqflite.dart';

abstract class LocalDatabaseReposetory {
  const LocalDatabaseReposetory();

  Future<Database> connection();

  Future<void> createTable(Database db, int verstion);

  Future<List<Map<String, Object?>>> readRecords();

  Future<void> insertRecord(Map<String, Object?> values);

  Future<void> updateRecord(int id, Map<String, Object?> values);

  Future<void> deleteRecordById(int id);

  Future<void> deleteRecords();
}
