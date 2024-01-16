import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteDeleteRecordsDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeDeleteAllRecords() => _reposetoryImpl.deleteRecords();
}
