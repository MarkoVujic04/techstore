// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techstore/presentation/home/widgets/best_selling.dart';
import 'package:techstore/presentation/home/widgets/categories_container.dart';
import 'package:techstore/presentation/home/widgets/header.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SizedBox(height: screenHeight * 0.03,),
            Categories(),
            SizedBox(height: screenHeight * 0.04,),
            TopSelling(),
          ],
        ),
      ),
    );
  }
}