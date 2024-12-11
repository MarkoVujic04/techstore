import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:techstore/common/helper/cart/cart_helper.dart';
import 'package:techstore/core/constants/stripe_consts.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';

class StripeService {
  final List<ProductOrderedEntity> products;

  StripeService._(this.products);

  static late StripeService instance;

  static void initialize(List<ProductOrderedEntity> products) {
    instance = StripeService._(products);
  }

  Future<void> makePayment() async {
    try {
      // Step 1: Create Payment Intent
      String? paymentIntentClientSecret = await _createPaymentIntent(
        CartHelper.calculateCartSubtotal(products).toInt(),
        "usd",
      );

      if (paymentIntentClientSecret == null) {
        print("Payment Intent creation failed.");
        return;
      }

      // Step 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Tech Store",
        ),
      );

      // Step 3: Present Payment Sheet
      await _processPayment();
    } catch (e) {
      print("Error in makePayment: $e");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.data != null) {
        return response.data['client_secret'];
      }

      throw Exception("Payment intent creation failed: No response data.");
    } catch (e) {
      print("Error in _createPaymentIntent: $e");
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment Successful!");
    } catch (e) {
      print("Error in _processPayment: $e");
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 1000;
    return calculatedAmount.toString();
  }
}
