import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/domain/auth/enitities/user_entity.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _profileImage(context),
        _card(context),
      ],
    );
  }

  Widget _profileImage(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.04),
      child: Container(
        height: screenHeight * 0.11,
        width: screenWidth * 0.11,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
       // AppNavigator.push(context,const CartPage());
      },
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Container(
          height: screenHeight * 0.11,
          width: screenWidth * 0.11,
          decoration: const BoxDecoration(
            color: Color(0xFF29B6F6),
            shape: BoxShape.circle
          ),
          child: Icon(Icons.shopping_bag_rounded, color: Colors.black)
        ),
        ),
    );
  }
}