import 'package:flutter/widgets.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductDescription extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDescription({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      textAlign: TextAlign.center,
      productEntity.description,
      style: TextStyle(
        fontSize: screenHeight * 0.019,
        color: AppColors.primary
      ),
    );
  }
}