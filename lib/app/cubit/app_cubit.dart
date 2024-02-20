import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/injections_container/di.dart' as di;
import 'package:store_app/database/local_database_services.dart';

import '../../helper/local/cache_helper.dart';
import '../../models/card_model.dart';
import '../../models/product_model.dart';
import '../../services/all_products_service.dart';
import '../extensions.dart';
import '../functions/check_connection_function.dart';
import '../functions/toast_snack_bar.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  final List<ProductModel> products = [];
  final List<dynamic> cachedFavorite =
      CacheHelper.getData(key: "Favorites") ?? [];

  final _localDatabaseServices = di.instance.get<LocalDatabaseServices>();

  //* Executed when scrolling down in the product screen
  void refreshProducts() {
    products.clear();
    getProducts();
  }

  //* Fetch all products data and then extraction first images and categories
  void getProducts() async {
    if (products.isNotEmpty) return;
    emit(ProductsLoadingState());
    if (!await hasConnection()) return emit(CheckConnectionState());
    await AllProductsService.getAllProducts().then((products) {
      //* Fill list products
      this.products.addAll(products);
      log(products[0].toString());
    }).then((_) {
      _extractionFirstImagesAndCategories();
      emit(ProductsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(ProductsErrorState());
    });
  }

  //* Add or delete product to favorite list and cached that in cache memory
  void changeFavorites(int productId) async {
    if (cachedFavorite.contains(productId)) {
      cachedFavorite.remove(productId);
      emit(ChangeFavoriteState());
      await CacheHelper.saveData(key: "Favorites", value: cachedFavorite);
    } else {
      cachedFavorite.add(productId);
      emit(ChangeFavoriteState());
      await CacheHelper.saveData(key: "Favorites", value: cachedFavorite);
    }
  }

  //* Get the first images and first categories for products list
  final List<Map<String, String>> firstImagesAndCategories = [];
  final List<String> categoriesImages = [];
  final List<String> categories = [];

  void _extractionFirstImagesAndCategories() {
    if (firstImagesAndCategories.isNotEmpty) return;
    final Map<String, String> imageAndCategory = {};
    _fillImagesAndCategoriesFromListProduct(imageAndCategory);
    _fillFirstImagesAndCategories(imageAndCategory);
    _fillFirstCategories();
    _fillFirstImages();
  }

  void _fillImagesAndCategoriesFromListProduct(
    Map<String, String> imageAndCategory,
  ) {
    for (ProductModel product in products) {
      if (!imageAndCategory.containsKey(product.category)) {
        imageAndCategory[product.category] = product.image;
      }
    }
  }

  void _fillFirstImagesAndCategories(Map<String, String> imageAndCategory) {
    firstImagesAndCategories.addAll(
      imageAndCategory.entries
          .map((e) => {"category": e.key, "image": e.value})
          .toList(),
    );
  }

  void _fillFirstCategories() {
    categories.addAll(
      firstImagesAndCategories
          .map((category) => category["category"]!)
          .toList(),
    );
  }

  void _fillFirstImages() {
    categoriesImages.addAll(
      firstImagesAndCategories.map((image) => image["image"]!).toList(),
    );
  }

  ///?________________________________________ Database Branch for ( User Card ) ________________________________________///

  final List<CardModel> cardUser = <CardModel>[];
  final List<int> quantityHelper = <int>[];
  int quantity = 1;

  //* Initialize the database when the application is launched for the first time
  void initLocalDB() => _localDatabaseServices
      .executeCreateLocalDatabase()
      .then((_) => _getProductsFromDB());

  //* Delete all data in database when the user logout
  void deleteProductsFromUserCard() => _localDatabaseServices
      .executeDeleteAllRecords()
      .then((_) => cardUser.clear());

  //* Execute insert function into database
  void addToCard({required ProductModel product}) async {
    await _localDatabaseServices
        .executeInsertIntoDatabase(product: product, quantity: quantity)
        .then((_) => _getProductsFromDB())
        .then((_) => emit(InsertDatabaseState()));
  }

  //* Update product quantity from the user card
  void updateProductQuantityFromUserCard({required int index}) async =>
      await _localDatabaseServices
          .executeUpdateInDatabase(
            id: cardUser[index].id,
            quantity: quantityHelper[index],
          )
          .then((_) => _getProductsFromDB())
          .then((_) => emit(UpdateDatabaseState()));

  //* Delete product from the user card
  void deleteProductFromUserCard({required int index}) {
    quantityHelper.removeAt(index);
    _localDatabaseServices
        .executeDelete(id: cardUser[index].id)
        .then((_) => _getProductsFromDB())
        .then((_) => emit(DeleteDatabaseState()));
  }

  //* Get products for the user card
  void _getProductsFromDB() async {
    cardUser.clear();
    await _localDatabaseServices
        .executeReadeDataFromDatabase()
        .then((products) => _fillCardUser(products))
        .then((_) => _calculatePriceAndQuantity());
  }

  //* Fill user card from the database
  void _fillCardUser(List<Map<String, Object?>> products) {
    cardUser.addAll(
      products.map((product) => CardModel.fromMap(product)).toList(),
    );
  }

  //* Calculation price and quantity after update card list item
  void _calculatePriceAndQuantity() {
    _fillQuantityHelper();
    _getTotalPriceForProduct();
    _getTotalPriceForAllProducts();
  }

  //* Fill quantity helper from card list
  void _fillQuantityHelper() {
    quantityHelper.clear();
    quantityHelper.addAll(cardUser.map((product) => product.quantity).toList());
    log("Quantity Helper: $quantityHelper");
  }

  //* Calculation total price for SINGLE product after update the quantity of the card list item
  List<double> totalPriceForProduct = [];
  void _getTotalPriceForProduct() {
    try {
      if (cardUser.isNotEmpty) {
        totalPriceForProduct = _calculationTotalPrice();
      }
    } catch (error) {
      log(error.toString(), name: "Get Total Price For Product");
    }
    log("Total Price For Product: $totalPriceForProduct");
  }

  //* Calculation the total price of [All] products after updating the quantity of the card list item
  double totalPrice = 0.0;
  void _getTotalPriceForAllProducts() {
    try {
      if (cardUser.isNotEmpty) _calculationTotalPriceForAllProduct();
    } catch (error) {
      log(error.toString(), name: "Get Total Price For All Products");
    }
    log("Total Price For All: $totalPrice");
  }

  //* Collection of product prices
  void _calculationTotalPriceForAllProduct() {
    // To round to just two decimal places,
    // we multiply by 100 and then round and then divide by 100
    totalPrice = _calculationTotalPrice()
        .reduce((prevPrice, currPrice) => prevPrice + currPrice)
        .roundingToTwoDecimal();
  }

  //* Calculation the total price for products
  List<double> _calculationTotalPrice() {
    return cardUser
        .map(
          (product) => (product.price * product.quantity)
              .toDouble()
              .roundingToTwoDecimal(),
        )
        .toList();
  }

  //* Increase quantity in card list (edit_product_screen)
  void increaseQuantityItem({
    required int index,
    required BuildContext context,
  }) {
    final isAvailableQuantity = checkQuantityProductIsAvailable(index);
    if (isAvailableQuantity) {
      quantityHelper[index]++;
      return;
    }
    toastSnackBar(
      context: context,
      text: "The maximum quantity of this product is $isAvailableQuantity",
    );
  }

  bool checkQuantityProductIsAvailable(int index) =>
      quantityHelper[index] <
      products[cardUser[index].idProduct - 1].rating!.count;

  //* Decrease quantity in card list (edit_product_screen)
  void decreaseQuantityItem({required int index}) {
    if (quantityHelper[index] > 1) quantityHelper[index]--;
  }

  //* Increase quantity in (product_details_screen)
  void increaseQuantityProduct({
    required ProductModel product,
    required BuildContext context,
  }) {
    if (quantity < product.rating!.count) {
      quantity++;
      return;
    }
    toastSnackBar(
      context: context,
      text: "The maximum quantity of this product is ${product.rating!.count}",
    );
  }

  //* Decrease quantity in (product_details_screen)
  void decreaseQuantityProduct() => {if (quantity > 1) quantity--};

  //* Check if the product is in the user card
  bool isInCard({required int idProduct}) =>
      cardUser.any((product) => product.idProduct == idProduct);

  //* Show edit confirmation when the quantity of the product in the user card is increased or decreased
  bool shouldShowUpdateConfirm({required int index}) =>
      cardUser[index].quantity != quantityHelper[index];
}
