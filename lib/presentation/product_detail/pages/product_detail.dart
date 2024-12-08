import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ProductImages(productEntity: productEntity,),
              SizedBox(height: screenHeight * 0.02,),
              ProductTitle(productEntity: productEntity),
              SizedBox(height: screenHeight * 0.01,),
              ProductPrice(productEntity: productEntity),
              SizedBox(height: screenHeight * 0.01,),
              Divider(height: screenHeight * 0.01, color: Colors.white,),
              SizedBox(height: screenHeight * 0.01,),
              ProductDescription(productEntity: productEntity),
              SizedBox(height: screenHeight * 0.02,),
              AddToBag(productEntity: productEntity),
          ],
        ),
      ),
    );
  }
}