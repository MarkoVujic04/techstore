import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/presentation/product_detail/widgets/add_to_bag.dart';
import 'package:techstore/presentation/product_detail/widgets/product_description.dart';
import 'package:techstore/presentation/product_detail/widgets/product_images.dart';
import 'package:techstore/presentation/product_detail/widgets/product_price.dart';
import 'package:techstore/presentation/product_detail/widgets/product_title.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ButtonStateCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: screenHeight * 0.1), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.secondBackground, 
                    height: screenHeight * 0.30, 
                    child: Center(
                      child: ProductImages(productEntity: productEntity), 
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ProductTitle(productEntity: productEntity),
                  SizedBox(height: screenHeight * 0.01),
                  ProductPrice(productEntity: productEntity),
                  SizedBox(height: screenHeight * 0.01),
                  Divider(height: screenHeight * 0.01, color: Colors.white),
                  if (productEntity.description != null &&
                      productEntity.description!.isNotEmpty) ...[
                    SizedBox(height: screenHeight * 0.01),
                    ProductDescription(productEntity: productEntity),
                  ],
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.background,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: AddToBag(productEntity: productEntity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
