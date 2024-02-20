import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteUpdateDB {
  final LocalDatabaseReposetory _reposetory =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeUpdateInDatabase({
    required int id,
    required int quantity,
  }) =>
      _reposetory.updateRecord(id, {colQuantity: quantity});
}
