import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';
import 'package:techstore/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:techstore/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:techstore/presentation/cart/widgets/check_out.dart';
import 'package:techstore/presentation/cart/widgets/product_ordered_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartProductsDisplayCubit()..displayCartProducts(),
        child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
          builder: (context, state) {
            if (state is CartProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartProductsLoaded) {
              return state.products.isEmpty ? _cartIsEmpty(context) : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    child: _products(context, state.products),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: screenHeight * 0.35,
                      child: Checkout(products: state.products),
                    ),
                  ),
                ],
              );
            }
            if (state is LoadCartProductsFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(BuildContext context, List<ProductOrderedEntity> products) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.separated(
      itemBuilder: (context, index) {
        return Center(
          child: ProductOrderedCard(productOrderedEntity: products[index]),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: screenHeight * 0.03),
      itemCount: products.length,
    );
  }

  Widget _cartIsEmpty(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Text("Cart Is Empty",
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
