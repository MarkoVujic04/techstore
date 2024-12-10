import 'package:dartz/dartz.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class GetCartProductsUseCase implements UseCase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<OrderRepository>().getCartProducts();
  }

}