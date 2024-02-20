import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteReadDB {
  final LocalDatabaseReposetory _reposetory =
      const LocalDatabaseReposetoryImpl();

  Future<List<Map<String, Object?>>> executeReadeDataFromDatabase() async =>
      await _reposetory.readRecords();
}
