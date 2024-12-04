import 'package:dartz/dartz.dart';
import 'package:techstore/data/product/models/product.dart';
import 'package:techstore/data/product/source/product_firebase_service.dart';
import 'package:techstore/domain/product/repository/product.dart';
import 'package:techstore/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository{
  @override
  Future<Either> getTopSelling() async{

    var products = await sl<ProductFirebaseService>().getTopSelling();
    return products.fold(
      (error){
        return Left(error);
      }, 
      (data){
        return Right(
          List.from(data).map((e) => ProductModel.fromMap(e).toEntity()).toList()
        );
      }
    );
  }
}