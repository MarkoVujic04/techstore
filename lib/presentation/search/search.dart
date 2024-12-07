import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/common/bloc/products/products_display_state.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/core/configs/theme/app_vectors.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/domain/product/usecases/get_products_by_categoryId.dart';
import 'package:techstore/domain/product/usecases/get_products_by_title.dart';
import 'package:techstore/presentation/home/widgets/product_card.dart';
import 'package:techstore/presentation/home/widgets/search_field.dart';
import 'package:techstore/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
  create: (context) => ProductsDisplayCubit(useCase: sl<GetProductsByTitleUseCase>()),
  child: Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.background,
      title: SearchField(),
    ),
    body: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductsLoaded) {
          return state.products.isEmpty 
              ? _notFound(context) 
              : Padding(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: _products(state.products, context),
              );
        }
        return Container(); // Default state
      },
    ),
  ),
);

  }

  Widget _notFound(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppVectors.notFound,
        ),
         Padding(
          padding: EdgeInsets.all(screenHeight * 0.03),
          child: Text(
            "Sorry, we couldn't find any matching result for your Search.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: screenHeight * 0.03
            ),
          ),
        )
      ],
    );
  }

 Widget _products(List<ProductEntity> products, BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return GridView.builder(
    itemCount: products.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: screenHeight * 0.001,
      mainAxisSpacing: screenHeight * 0.02,
      childAspectRatio: screenHeight * 0.00092,
    ),
    itemBuilder: (BuildContext context, int index) {
      return ProductCard(productEntity: products[index]);
    },
  );
}

}

