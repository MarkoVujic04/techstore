import 'package:dartz/dartz.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/data/order/model/order_registration_req.dart';
import 'package:techstore/domain/order/repositories/order.dart';
import 'package:techstore/service_locator.dart';

class OrderRegistrationUseCase implements Usecase<Either,OrderRegistrationReq> {


  @override
  Future<Either> call({OrderRegistrationReq ?  params}) async {
    return await sl<OrderRepository>().orderRegistration(params!);
  }

}