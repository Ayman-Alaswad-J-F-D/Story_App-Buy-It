import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';
import '../../models/product_model.dart';
import '../../widget/custom_app_bar.dart';
import 'components/add_to_card_bottom_sheet.dart';
import 'components/product_description.dart';
import 'components/product_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit.get(context).quantity = 1;
        return Scaffold(
          appBar: CustomAppBar(textTitle: 'Details Product'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProductDetails(product: product),
                ProductDescription(product: product),
              ],
            ),
          ),
          bottomSheet: AddToCardBottomSheet(product: product),
        );
      },
    );
  }
}
