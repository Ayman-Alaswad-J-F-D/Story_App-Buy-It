import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteDeleteDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeDelete({required int id}) =>
      _reposetoryImpl.deleteRecordById(id);
}
