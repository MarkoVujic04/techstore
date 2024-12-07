import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/categories/categories_display_cubit.dart';
import 'package:techstore/common/bloc/categories/categories_display_state.dart';
import 'package:techstore/common/helper/image_display.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/presentation/category_products/pages/category_products.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        title: Text(
          "Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CategoriesDisplayCubit()..displayCategories(),
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _categories(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categories(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoriesLoaded) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                     AppNavigator.push(context, CategoryProductsPage(categoryEntity: state.categories[index]));
                  },
                  child: Container(
                    height: screenHeight * 0.11,
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(screenHeight * 0.02),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                            image: NetworkImage(
                            ImageDisplayHelper.generateCategoryImageURL(
                             state.categories[index].image
                            )
                            )
                            )
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Text(
                          state.categories[index].title,
                          style: TextStyle(
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: screenHeight * 0.03,
                  ),
              itemCount: state.categories.length);
        }
        return Container();
      },
    );
  }
}
