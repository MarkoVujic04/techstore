import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/basic_reactive_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/data/auth/models/user_creation_req.dart';
import 'package:techstore/domain/auth/usecases/signup.dart';
import 'package:techstore/presentation/auth/bloc/age_selection_cubit.dart';
import 'package:techstore/presentation/auth/bloc/ages_display_cubit.dart';
import 'package:techstore/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:techstore/presentation/auth/widgets/ages.dart';
import 'package:techstore/presentation/home/pages/home.dart';

class UserInfoPage extends StatelessWidget {
  final UserCreationReq userCreationReq;
  const UserInfoPage({
    required this.userCreationReq,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GenderSelectionCubit()),
          BlocProvider(create: (context) => AgeSelectionCubit()),
          BlocProvider(create: (context) => AgesDisplayCubit()),
          BlocProvider(create: (context) => ButtonStateCubit())
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (userCreationReq.email == null ||
                userCreationReq.email!.isEmpty) {
              var snackbar = SnackBar(
                  content: Text("Email is required"),
                  behavior: SnackBarBehavior.floating);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              return;
            }

            if (userCreationReq.password == null ||
                userCreationReq.password!.isEmpty) {
              var snackbar = SnackBar(
                  content: Text("Password is required"),
                  behavior: SnackBarBehavior.floating);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              return;
            }
            if (state is ButtonSuccessState) {
                AppNavigator.push(context, const HomePage());
              }
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: _tellUs(context)),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    _genders(context),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Center(child: howOld(context)),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    _age(context),
                  ],
                ),
              ),
              const Spacer(),
              _finishButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _tellUs(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      'Lets improve ur experience',
      style:
          TextStyle(fontSize: screenHeight * 0.04, fontWeight: FontWeight.w500),
    );
  }

  Widget _genders(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GenderSelectionCubit, int>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          genderTile(context, 1, 'Man'),
          SizedBox(
            width: screenWidth * 0.05,
          ),
          genderTile(context, 2, 'Woman'),
        ],
      );
    });
  }

  Expanded genderTile(BuildContext context, int genderIndex, String gender) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectGender(genderIndex);
        },
        child: Container(
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
              color: context.read<GenderSelectionCubit>().selectedIndex ==
                      genderIndex
                  ? Color(0xFF29B6F6)
                  : AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget howOld(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      'What is your age?',
      style:
          TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.w500),
    );
  }

  Widget _age(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<AgeSelectionCubit, String>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          AppBottomsheet.display(
              context,
              MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: context.read<AgeSelectionCubit>(),
                ),
                BlocProvider.value(
                    value: context.read<AgesDisplayCubit>()..displayAges())
              ], child: const Ages()));
        },
        child: Container(
          height: screenHeight * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(state), const Icon(Icons.keyboard_arrow_down)],
          ),
        ),
      );
    });
  }

  Widget _finishButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      color: AppColors.secondBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(builder: (context) {
          return BasicReactiveButton(
              onPressed: () {
                userCreationReq.gender =
                    context.read<GenderSelectionCubit>().selectedIndex;
                userCreationReq.age =
                    context.read<AgeSelectionCubit>().selectedAge;
                context
                    .read<ButtonStateCubit>()
                    .execute(usecase: SignUpUseCase(), params: userCreationReq);
              },
              title: 'Finish');
        }),
      ),
    );
  }
}
