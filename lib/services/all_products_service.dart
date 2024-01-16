import '../app/constants/constants.dart';
import '../helper/remote/products_api.dart';
import '../models/product_model.dart';
import 'endpoints/products_endpoints.dart';

class AllProductsService {
  static Future<List<ProductModel>> getAllProducts() async {
    const ProductsApi api = ProductsApi();

    final List<dynamic> reaponse =
        await api.get("$baseUrlProduct/$ALLPRODUCTS_ENDPOINT");

    final List<Map<String, dynamic>> listData =
        reaponse.map((item) => Map<String, dynamic>.from(item)).toList();

    final List<ProductModel> productList =
        listData.map((product) => ProductModel.fromJson(product)).toList();

    return productList;
  }
}
