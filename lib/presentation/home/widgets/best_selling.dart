import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/presentation/home/bloc/top_selling_display_cubit.dart';
import 'package:techstore/presentation/home/bloc/top_selling_display_state.dart';
import 'package:techstore/presentation/home/widgets/product_card.dart';


class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TopSellingDisplayCubit()..displayProducts(),
      child: BlocBuilder < TopSellingDisplayCubit, TopSellingDisplayState > (
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const CircularProgressIndicator();
          }
          if (state is ProductsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _topSelling(context),
                  ],
                ),
                SizedBox(height: screenHeight * 0.034 ),
                _products(state.products, context)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

   Widget _topSelling(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
         horizontal: screenWidth * 0.05,
       ),
      child: Text(
        'Top Selling',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenHeight * 0.03
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.49,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
         horizontal: screenWidth * 0.038,
       ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index) {
          return ProductCard(
            productEntity: products[index],
          );
        },
        separatorBuilder: (context,index) => SizedBox(width: screenWidth * 0.03,),
        itemCount: products.length
        ),
    );
  }
}