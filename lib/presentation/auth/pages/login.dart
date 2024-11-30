import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/basic_reactive_button.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';
import 'package:techstore/domain/auth/usecases/signin.dart';
import 'package:techstore/presentation/auth/pages/forgot_password.dart';
import 'package:techstore/presentation/auth/pages/signup.dart';
import 'package:techstore/presentation/home/pages/home.dart';

class LoginPage extends StatelessWidget {

  final UserSigninReq signinReq;
  LoginPage({super.key, required this.signinReq});

  
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        
        child: BlocListener<ButtonStateCubit,ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState){
                var snackbar = SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              if (state is ButtonSuccessState) {
                AppNavigator.pushAndRemove(context, const HomePage());
              }
            },
          child: Column(
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
        ),
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
        controller: _emailCon,
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
        controller: _passwordCon,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: "Enter Password", hintStyle: TextStyle(color: Colors.grey.shade400)
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return  BasicReactiveButton(
        onPressed: () {
          signinReq.email = _emailCon.text;
          signinReq.password = _passwordCon.text;
          context.read<ButtonStateCubit>().execute(usecase: SignInUseCase(),
          params: signinReq);
        }, 
        title: "Continue"
      );
      },
      
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
               AppNavigator.push(context, ForgotPasswordPage());
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