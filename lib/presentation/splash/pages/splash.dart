import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';
import 'package:techstore/domain/auth/usecases/signin.dart';
import 'package:techstore/presentation/auth/pages/login.dart';
import 'package:techstore/presentation/home/pages/home.dart';
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
          AppNavigator.pushReplacement(context, LoginPage(signinReq: UserSigninReq(email: "")));
        }
        if(state is Authenticated) {
          AppNavigator.pushReplacement(context, const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppVectors.appLogo, height: screenHeight * 0.2, width: screenWidth * 0.4,)),
          ],
        ),
      ),
    );
  }
}
