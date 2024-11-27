import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/presentation/auth/pages/forgot_password.dart';
import 'package:techstore/presentation/auth/pages/password_page.dart';
import 'package:techstore/presentation/auth/pages/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _signInText(context),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          _emailField(context),
          SizedBox(height: screenHeight * 0.02),
          _passwordField(context),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _forgotPassword(context),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          _continueButton(context),
          SizedBox(height: screenHeight * 0.02),
          _createAccount(context),
        ],
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      "Sign In",
      style: TextStyle(
        fontSize: screenHeight * 0.05,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: "Enter Email", hintStyle: TextStyle(color: Colors.grey.shade400)
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: "Enter Password", hintStyle: TextStyle(color: Colors.grey.shade400)
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return MyButton(
      onPressed: () {
        AppNavigator.push(context, const PasswordPage());
      }, 
      title: "Continue"
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "You dont have an account?",
            style: TextStyle(
              color: Colors.grey.shade300
            )
          ),
          TextSpan(
            text: " Create one",
            recognizer: TapGestureRecognizer()..onTap = () {
              AppNavigator.push(context, SignupPage());
            },
            style: TextStyle(
              color: const Color(0xFF29B6F6),
              fontWeight: FontWeight.bold,
            )
          ),
        ]
      )
    );
  }
  
  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Forgot password?",
            style: TextStyle(
              color: Colors.grey.shade300
            )
          ),
          TextSpan(
            text: " Reset it",
            recognizer: TapGestureRecognizer()..onTap = () {
               AppNavigator.push(context, const ForgotPasswordPage());
            },
            style: TextStyle(
              color: const Color(0xFF29B6F6),
              fontWeight: FontWeight.bold,
            )
          ),
        ]
      )
    );
  }
}