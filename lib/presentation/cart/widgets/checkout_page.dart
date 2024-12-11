import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/button/button_state.dart';
import 'package:techstore/common/bloc/button/button_state_cubit.dart';
import 'package:techstore/common/helper/cart/cart_helper.dart';
import 'package:techstore/common/helper/navigator/app_navigator.dart';
import 'package:techstore/common/widgets/basic_reactive_button.dart';
import 'package:techstore/core/configs/theme/app_colors.dart';
import 'package:techstore/data/order/model/order_registration_req.dart';
import 'package:techstore/data/stripe/services/stripe_service.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';
import 'package:techstore/domain/order/usecases/order_registration.dart';
import 'package:techstore/presentation/cart/widgets/order_placed.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  CheckoutPage({super.key, required this.products});

  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "Finish Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text("Something is wrong. Please try again."),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.03),
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addressField(context),
                  BasicReactiveButton(
                    onPressed: () async {
                      try {
                        // Initialize StripeService
                        StripeService.initialize(products);

                        // Start Stripe payment process
                        await StripeService.instance.makePayment();

                        // Register the order after successful payment
                        await context.read<ButtonStateCubit>().execute(
                          usecase: OrderRegistrationUseCase(),
                          params: OrderRegistrationReq(
                            products: products,
                            createdDate: DateTime.now().toString(),
                            itemCount: products.length,
                            totalPrice:
                                CartHelper.calculateCartSubtotal(products),
                            shippingAddress: _addressCon.text,
                          ),
                        );

                        // Navigate to OrderPlaced page
                        AppNavigator.pushAndRemove(context, OrderPlaced());
                      } catch (e) {
                        // Handle any errors during payment or order registration
                        var snackbar = SnackBar(
                          content: Text(
                            "Payment failed or something went wrong. Please try again.",
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    height: screenHeight * 0.09,
                    widthFactor: 0.9,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${CartHelper.calculateCartSubtotal(products).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Pay Here",
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: TextField(
        controller: _addressCon,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
            horizontal: screenHeight * 0.02,
          ),
          hintText: "Shipping Address",
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
