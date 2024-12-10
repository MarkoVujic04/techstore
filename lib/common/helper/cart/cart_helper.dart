import 'package:techstore/domain/order/entities/product_ordered.dart';

class CartHelper {
  static double calculateCartSubtotal(List<ProductOrderedEntity> products) {
    double subtotalPrice = 0.0;
    for (var item in products) {
      subtotalPrice += item.totalPrice ?? 0.0; // Default to 0.0 if null
    }
    return subtotalPrice;
  }
}
