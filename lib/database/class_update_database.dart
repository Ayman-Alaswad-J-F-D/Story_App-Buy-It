import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

mixin ExecuteUpdateDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeUpdateInDatabase({
    required int id,
    required int quantity,
  }) =>
      _reposetoryImpl.updateRecord(id, {colQuantity: quantity});
}
