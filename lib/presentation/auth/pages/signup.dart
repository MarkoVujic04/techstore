import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/data/auth/models/user_creation_req.dart';
import 'package:techstore/presentation/auth/pages/forgot_password.dart';
import 'package:techstore/presentation/auth/pages/login.dart';
import 'package:techstore/presentation/auth/pages/user_info_page.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _signUpText(context),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          _emailField(context),
          SizedBox(height: screenHeight * 0.02),
          _passwordField(context),
          SizedBox(height: screenHeight * 0.02),
          _firstNameField(context),
          SizedBox(height: screenHeight * 0.02),
          _lastNameField(context),
          SizedBox(height: screenHeight * 0.04),
          _continueButton(context),
          SizedBox(height: screenHeight * 0.02),
          _createAccount(context),
        ],
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      "Sign Up",
      style: TextStyle(
        fontSize: screenHeight * 0.05,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _firstNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: "Firstname", hintStyle: TextStyle(color: Colors.grey.shade400)
        ),
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: "Lastname", hintStyle: TextStyle(color: Colors.grey.shade400)
        ),
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
        AppNavigator.push(context, UserInfoPage(userCreationReq: UserCreationReq(
          firstName: _firstNameCon.text,
          email: _emailCon.text,
          lastName: _lastNameCon.text,
          password: _passwordCon.text,
        )));
      }, 
      title: "Continue"
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Already have an account?",
            style: TextStyle(
              color: Colors.grey.shade300
            )
          ),
          TextSpan(
            text: " Sign In",
            recognizer: TapGestureRecognizer()..onTap = () {
              AppNavigator.push(context, const LoginPage());
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