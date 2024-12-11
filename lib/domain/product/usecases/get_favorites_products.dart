import 'package:dartz/dartz.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/domain/product/repository/product.dart';
import 'package:techstore/service_locator.dart';

class GetFavoritesProductsUseCase implements UseCase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<ProductRepository>().getFavoritesProducts();
  }

}