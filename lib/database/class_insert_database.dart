import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';
import 'package:store_app/models/product_model.dart';

mixin ExecuteInsertDB {
  final LocalDatabaseReposetoryImpl _reposetoryImpl =
      const LocalDatabaseReposetoryImpl();

  Future<void> executeInsertIntoDatabase({
    required ProductModel product,
    required int quantity,
  }) =>
      _reposetoryImpl.insertRecord(_fillInsertValues(product, quantity));
}

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
