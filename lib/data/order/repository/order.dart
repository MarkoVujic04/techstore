import 'package:dartz/dartz.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/data/order/model/order_registration_req.dart';
import 'package:techstore/data/order/model/product_ordered.dart';
import 'package:techstore/data/order/source/order_firebase_service.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository{
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    return sl<OrderFirebaseService>().addToCart(addToCartReq);
  }
  
  @override
  Future<Either> getCartProducts() async{
    var returnedData =
        await sl<OrderFirebaseService>().getCartProducts();
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductOrderedModel.fromMap(e).toEntity())
          .toList());
    });
  }
  
  @override
  Future<Either> removeCartProduct(String id) async{
    var returnedData =
        await sl<OrderFirebaseService>().removeCartProduct(id);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async{
    var returnedData =
        await sl<OrderFirebaseService>().orderRegistration(order);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }

}