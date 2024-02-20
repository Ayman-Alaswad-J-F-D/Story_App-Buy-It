import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteCreateDB {
  final LocalDatabaseReposetory _reposetory =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeCreateLocalDatabase() async => _reposetory.initDB();
}
