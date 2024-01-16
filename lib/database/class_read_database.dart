import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteReadDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<List<Map<String, Object?>>> executeReadeDataFromDatabase() async =>
      await _reposetoryImpl.readRecords();
}
