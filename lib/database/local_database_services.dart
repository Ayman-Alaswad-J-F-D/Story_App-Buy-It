import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/models/product_model.dart';

abstract class LocalDatabaseServices {
  Future<void> executeCreateLocalDatabase();

  Future<List<Map<String, Object?>>> executeReadeDataFromDatabase();

  Future<void> executeInsertIntoDatabase({
    required ProductModel product,
    required int quantity,
  });

  Future<void> executeUpdateInDatabase({
    required int id,
    required int quantity,
  });

  Future<void> executeDelete({required int id});

  Future<void> executeDeleteAllRecords();
}

class LocalDatabaseServicesImpl implements LocalDatabaseServices {
  final LocalDatabaseReposetory _localDatabaseReposetory;

  const LocalDatabaseServicesImpl(this._localDatabaseReposetory);

  @override
  Future<void> executeCreateLocalDatabase() async =>
      _localDatabaseReposetory.initDB();

  @override
  Future<List<Map<String, Object?>>> executeReadeDataFromDatabase() async =>
      await _localDatabaseReposetory.readRecords();

  @override
  Future<void> executeInsertIntoDatabase({
    required ProductModel product,
    required int quantity,
  }) =>
      _localDatabaseReposetory
          .insertRecord(_fillInsertValues(product, quantity));

  Map<String, Object?> _fillInsertValues(ProductModel product, int quantity) {
    return {
      colProductId: product.id,
      colTitle: product.title,
      colDesc: product.description,
      colImage: product.image,
      colCategory: product.category,
      colPrice: product.price,
      colQuantity: quantity,
      colDataTime: DateTime.now().toString(),
    };
  }

  @override
  Future<void> executeUpdateInDatabase({
    required int id,
    required int quantity,
  }) =>
      _localDatabaseReposetory.updateRecord(id, {colQuantity: quantity});

  @override
  Future<void> executeDelete({required int id}) =>
      _localDatabaseReposetory.deleteRecordById(id);

  @override
  Future<void> executeDeleteAllRecords() =>
      _localDatabaseReposetory.deleteRecords();
}
