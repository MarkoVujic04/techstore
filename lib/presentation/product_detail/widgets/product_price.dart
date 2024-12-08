import 'package:flutter/widgets.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductPrice({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
      child: Text(
        "\$" + '${

            
        productEntity.discountedPrice != 0 ?
        productEntity.discountedPrice.toString() : productEntity.price.toString()
        }',
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontWeight: FontWeight.w600,
          color: Color(0xFF29B6F6),
        ),
      ),
    );
  }
}