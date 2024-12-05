import 'package:flutter/material.dart';
import 'package:techstore/common/helper/image_display.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String imageUrl =
        ImageDisplayHelper.generateProductImageURL(productEntity.images[0]);
    print("Product Title: ${productEntity.title}");
    print("Image Filename: ${productEntity.images}");

    return GestureDetector(
      onTap: () {
        // AppNavigator.push(context, ProductDetailPage(productEntity: productEntity,));
      },
      child: Container(
        width: screenWidth * 0.45,
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(screenHeight * 0.02),
          border: Border.all(
            color: AppColors.primary,
            width: screenWidth * 0.002
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black, 
                      Color(0xFF29B6F6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
              
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.02),
                    topRight: Radius.circular(screenHeight * 0.02),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.title,
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          productEntity.discountedPrice == 0
                              ? "${productEntity.price}\$"
                              : "${productEntity.discountedPrice}\$",
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF29B6F6),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Text(
                          productEntity.discountedPrice == 0
                              ? ''
                              : "${productEntity.price}\$",
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
