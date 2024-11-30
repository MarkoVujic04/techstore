import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/basic_reactive_button.dart';
import 'package:techstore/common/widgets/my_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/auth/usecases/reset_password.dart';
import 'package:techstore/presentation/auth/pages/password_reset_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: AppColors.background,
      ),
      body: BlocProvider(
        create:(context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit,ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState){
                var snackbar = SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              if (state is ButtonSuccessState) {
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
              SizedBox(height: screenHeight * 0.04),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      "Reset Password",
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

  Widget _continueButton() {
    return Builder(
      builder:(context) {
        return BasicReactiveButton(
        onPressed: () {
          context.read<ButtonStateCubit>().execute(
            usecase: ResetPasswordUseCase(),
            params: _emailCon.text,
          );
          AppNavigator.push(context, PasswordResetEmailPage());
        }, 
        title: "Continue"
      );
      },
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