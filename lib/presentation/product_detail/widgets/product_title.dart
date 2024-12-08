import 'package:flutter/widgets.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductTitle({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
      child: Text(
        productEntity.title,
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}