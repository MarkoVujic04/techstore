// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/categories/categories_display_cubit.dart';
import 'package:techstore/common/bloc/categories/categories_display_state.dart';
import 'package:techstore/common/helper/image_display.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/domain/category/entity/category_entity.dart';
import 'package:techstore/presentation/all_categories/pages/all_categories.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CategoriesLoaded) {
            return Column(
              children: [
                _seaAll(context),
                SizedBox(height: screenHeight * 0.034),
                _categories(state.categories, context),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _seaAll(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Categories',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, const AllCategoriesPage());
            },
            child: Text(
              'See All',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: screenHeight * 0.027),
            ),
          )
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> categories, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.15,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      ImageDisplayHelper.generateCategoryImageURL(categories[index].image)
                    )
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                categories[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: screenWidth * 0.07),
        itemCount: categories.length,
      ),
    );
  }
}
