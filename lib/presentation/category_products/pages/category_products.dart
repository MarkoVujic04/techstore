import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/common/bloc/products/products_display_state.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/category/entity/category_entity.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/presentation/home/widgets/product_card.dart';
import 'package:techstore/service_locator.dart';

import '../../../domain/product/usecases/get_products_by_categoryId.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const CategoryProductsPage({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
      ),
      body: BlocProvider(
        create:(context) => ProductsDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>())..displayProducts(params: categoryEntity.categoryId),
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder:(context, state) {
            if(state is ProductsLoading) {
              return const Center(child:  CircularProgressIndicator());
            }
            if(state is ProductsLoaded) {
              return Padding(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Column(
                  children: [
                    _categoryInfo(state.products, context),
                    SizedBox(height: screenHeight * 0.04),
                    _products(state.products, context),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }


  
  Widget _categoryInfo(List<ProductEntity> products, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      '${categoryEntity.title} (${products.length})',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: screenHeight * 0.03
      ),
    );
  }

  Widget _products(List<ProductEntity> products, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: screenHeight * 0.001,
            mainAxisSpacing: screenHeight * 0.02,
            childAspectRatio: screenHeight * 0.00091
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(productEntity: products[index]);
          },
      ),
    );
  }


}