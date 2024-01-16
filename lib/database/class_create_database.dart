import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteCreateDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeCreateLocalDatabase() async => _reposetoryImpl.initDB();
}
