import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';

class BasicReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? widthFactor;
  final Widget? content;

  const BasicReactiveButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.widthFactor = 0.9, 
    this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * (widthFactor ?? 1.0),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? screenHeight * 0.08),
        ),
        child: Container(
          height: height ?? screenHeight * 0.08,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _initial(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * (widthFactor ?? 1.0), 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? screenHeight * 0.08),
          backgroundColor: const Color(0xFF29B6F6),
        ),
        child: content ??
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: screenHeight * 0.03,
              ),
            ),
      ),
    );
  }
}
