import 'package:dartz/dartz.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/data/order/source/order_firebase_service.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository{
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    return sl<OrderFirebaseService>().addToCart(addToCartReq);
  }

}