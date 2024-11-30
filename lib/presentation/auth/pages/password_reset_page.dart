import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';
import 'package:techstore/presentation/auth/pages/login.dart';

class PasswordResetEmailPage extends StatelessWidget {
  const PasswordResetEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailSending(context),
           SizedBox(height: screenHeight * 0.08,),
          _sentEmail(),
           SizedBox(height: screenHeight * 0.08,),
          _returnToLoginButton(context)
        ],
      ),
    );
  }
  Widget _emailSending(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;
      return Center(
      child: Image.asset(
        AppVectors.outgoingmail,
        height: screenHeight * 0.2,
        width: screenWidth * 0.6,
      ),
    );
  }

  Widget _sentEmail() {
    return const Center(
      child: Text(
        'We Sent you an Email to reset your password.'
      ),
    );
  }

  Widget _returnToLoginButton(BuildContext context) {
    return MyButton(
      onPressed: (){
        AppNavigator.pushReplacement(context, LoginPage(signinReq: UserSigninReq(email: ""),));
      },
      title: 'Return to Login'
    );
  }
}