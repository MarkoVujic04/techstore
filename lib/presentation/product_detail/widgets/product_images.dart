import 'package:flutter/material.dart';
import 'package:techstore/common/helper/image_display.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.35,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: screenWidth * 0.5,
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.all(color: Colors.white, width: screenWidth * 0.002),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  ImageDisplayHelper.generateProductImageURL(productEntity.images[index])
                )
              )
            ),
          );
        }, 
        separatorBuilder: (context,index) =>  SizedBox(width: screenWidth * 0.03,),
        itemCount: productEntity.images.length
      ),
    );
  }
}