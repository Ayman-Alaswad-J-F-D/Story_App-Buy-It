abstract class LocalDatabaseReposetory {
  const LocalDatabaseReposetory();

  Future<void> initDB();

  Future<List<Map<String, Object?>>> readRecords();

  Future<void> insertRecord(Map<String, Object?> values);

  Future<void> updateRecord(int id, Map<String, Object?> values);

  Future<void> deleteRecordById(int id);

  Future<void> deleteRecords();
}
