import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF29B6F6),
        ),
        backgroundColor: AppColors.background,
      ),
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
          _passwordField(context),
          SizedBox(height: screenHeight * 0.04),
          _continueButton(),
          SizedBox(height: screenHeight * 0.02),
          _forgotPassword(context),
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

  Widget _continueButton() {
    return MyButton(
      onPressed: () {}, 
      title: "Continue"
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Forgot your password?",
            style: TextStyle(
              color: Colors.grey.shade300
            )
          ),
          TextSpan(
            text: " Reset it",
            recognizer: TapGestureRecognizer()..onTap = () {

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