import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/helper/image_display.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';
import 'package:techstore/presentation/cart/bloc/cart_products_display_cubit.dart';

class ProductOrderedCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const ProductOrderedCard({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.15,
      width: screenWidth * 0.95,
      padding: EdgeInsets.all(screenHeight * 0.02),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              ImageDisplayHelper.generateProductImageURL(
                                  productOrderedEntity.productImage))),
                      borderRadius: BorderRadius.circular(screenHeight * 0.01),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.025,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productOrderedEntity.productTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.027),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$${productOrderedEntity.productPrice}',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: screenHeight * 0.025),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CartProductsDisplayCubit>().removeProduct(productOrderedEntity);
                  },
                  child: Container(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.1,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Icon(
                      Icons.delete,
                      size: screenHeight * 0.03,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
