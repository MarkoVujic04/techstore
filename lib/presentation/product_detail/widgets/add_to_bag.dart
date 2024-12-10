import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/basic_reactive_button.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/domain/order/usecases/add_to_cart_usecase.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/presentation/cart/pages/cart.dart';

class AddToBag extends StatelessWidget {
  final ProductEntity productEntity;

  const AddToBag({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final double priceToSave = productEntity.discountedPrice > 0
        ? productEntity.discountedPrice.toDouble()
        : productEntity.price.toDouble();

    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if(state is ButtonSuccessState) {
          AppNavigator.push(context, CartPage());
        }
        if(state is ButtonFailureState) {
          var snackbar = SnackBar(
                  content: Text("Something is wrong"),
                  behavior: SnackBarBehavior.floating);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BasicReactiveButton(
            onPressed: () {
              context.read<ButtonStateCubit>().execute(
                usecase: AddToCartUseCase(),
                params: AddToCartReq(
                  productId: productEntity.productId,
                  productTitle: productEntity.title,
                  productImage: productEntity.images[0],
                  productPrice: priceToSave,
                  createdDate: DateTime.now().toString(),
                ),
              );
            },
            height: screenHeight * 0.09,
            widthFactor: 0.9,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${priceToSave.toStringAsFixed(2)}", 
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Add To Bag",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenHeight * 0.027,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
