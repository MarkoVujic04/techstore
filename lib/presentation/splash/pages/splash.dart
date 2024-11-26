import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/presentation/auth/pages/login.dart';
import 'package:techstore/presentation/splash/bloc/splash_cubit.dart';
import 'package:techstore/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<SplashCubit,SplashState>(
      listener: (context, state) {
        if(state is Unauthenticated) {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            )
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppVectors.appLogo, height: screenHeight * 0.2, width: screenWidth * 0.4,)), // Corrected reference
          ],
        ),
      ),
    );
  }
}
