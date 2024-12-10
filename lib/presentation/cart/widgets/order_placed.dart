import 'package:flutter/material.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/presentation/home/pages/home.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppVectors.orderPlaced
            ),
          ),
          SizedBox(height: screenHeight * 0.03,),
          Text("Your order is placed",
            style: TextStyle(
              fontSize: screenHeight * 0.03
            ),
          ),
          SizedBox(height: screenHeight * 0.15,),
          MyButton(
          onPressed:() {
            AppNavigator.pushAndRemove(context, HomePage());
          }, 
          title: "Finish"
          ),
        ],
      ),
    );
  }
}