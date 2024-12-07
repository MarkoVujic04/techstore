import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/presentation/product_detail/widgets/product_images.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
                ProductImages(productEntity: productEntity,),
          ],
        ),
      ),
    );
  }
}