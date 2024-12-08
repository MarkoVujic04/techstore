import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class AddToBag extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToBag({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screenHeight * 0.09,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: const Color(0xFF29B6F6),
            borderRadius: BorderRadius.circular(screenHeight * 0.2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$" +
                      '${productEntity.discountedPrice != 0 ? productEntity.discountedPrice.toString() : productEntity.price.toString()}',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),
                ),
                Text("Add To Bag",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenHeight * 0.027,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
