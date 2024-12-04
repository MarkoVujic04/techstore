import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/domain/product/repository/product.dart';
import 'package:techstore/service_locator.dart';

class GetTopSellingUseCase implements Usecase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<ProductRepository>().getTopSelling();
  }

}