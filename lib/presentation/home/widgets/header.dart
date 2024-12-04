import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/core/configs/theme/app_images.dart';
import 'package:techstore/domain/auth/enitities/user_entity.dart';
import 'package:techstore/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:techstore/presentation/home/bloc/user_info_display_state.dart';
import 'package:techstore/presentation/home/widgets/search_field.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return Padding(
              padding: EdgeInsets.all(screenHeight * 0.04),
              child: const CircularProgressIndicator(),
            );
          }
          if (state is UserInfoLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _profileImage(context, state.user),
                Expanded(child: SearchField()),
                _card(context),
              ],
            );
          }
          return Container(

          );
        },
      ),
    );
  }

  Widget _profileImage(BuildContext context, UserEntity user) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.04),
      child: Container(
        height: screenHeight * 0.11,
        width: screenWidth * 0.11,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: user.image.isEmpty ?
            AssetImage(
              AppImages.profile
            ) : NetworkImage(user.image), fit: BoxFit.contain
          ),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // AppNavigator.push(context,const CartPage());
      },
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Container(
            height: screenHeight * 0.11,
            width: screenWidth * 0.11,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: screenWidth * 0.005),
                color: AppColors.background, shape: BoxShape.circle),
            child: Icon(Icons.shopping_bag_rounded, color: Color(0xFF29B6F6))),
      ),
    );
  }
}
