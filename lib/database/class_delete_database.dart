import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteDeleteDB {
  final LocalDatabaseReposetory _reposetory =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeDelete({required int id}) =>
      _reposetory.deleteRecordById(id);
}
