import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteDeleteRecordsDB {
  final LocalDatabaseReposetory _reposetory =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeDeleteAllRecords() => _reposetory.deleteRecords();
}
