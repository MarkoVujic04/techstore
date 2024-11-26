// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double ? height;
  const MyButton({super.key, required this.onPressed, required this.title, this.height});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.08,
      width: screenWidth * 0.90,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? screenHeight * 0.05),
          backgroundColor: const Color(0xFF29B6F6),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.035,
          ),
        ),
      ),
    );
  }
}