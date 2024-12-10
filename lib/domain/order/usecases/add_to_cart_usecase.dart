import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class AddToCartUseCase implements Usecase<Either,AddToCartReq> {


  @override
  Future<Either> call({AddToCartReq ? params}) async {
    return await sl<OrderRepository>().addToCart(params!);
  }

}