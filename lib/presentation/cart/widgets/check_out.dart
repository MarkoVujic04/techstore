import 'package:flutter/material.dart';
import 'package:techstore/common/helper/cart/cart_helper.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';
import 'package:techstore/presentation/cart/widgets/checkout_page.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({
    required this.products,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.02),
      height: MediaQuery.of(context).size.height / 3.5,
      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Subtotal',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenHeight * 0.027
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products).toString()}',
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.027
                ),
              )
            ],
          ),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Cost',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenHeight * 0.027
                ),
              ),
              Text(
                '\$8',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.027
                ),
              )
            ],
          ),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenHeight * 0.027
                ),
              ),
              Text(
                '\$0.0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.027
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Total',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenHeight * 0.027
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products) + 8 }',
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.027
                ),
              )
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          MyButton(
            onPressed: (){
              AppNavigator.push(context, CheckoutPage(products: products,));
            },
            title: 'Checkout',
          )
        ],
      ),
    );
  }
}