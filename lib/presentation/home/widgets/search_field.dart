import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
       padding: EdgeInsets.symmetric(
         horizontal: screenHeight * 0.01
       ),
      child: TextField(
        readOnly: true,
        onTap: (){
          //AppNavigator.push(context, const SearchPage());
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(screenHeight * 0.01),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.1)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.1)
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF29B6F6)),
          hintText: 'search',
        ),
      ),
    );
  }
}