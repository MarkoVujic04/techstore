import 'package:dartz/dartz.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class RemoveCartUseCase implements UseCase<Either,String> {


  @override
  Future<Either> call({String ? params}) async {
    return await sl<OrderRepository>().removeCartProduct(params!);
  }

}