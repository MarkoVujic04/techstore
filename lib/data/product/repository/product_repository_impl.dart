import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:techstore/data/product/models/product.dart';
import 'package:techstore/data/product/source/product_firebase_service.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
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
  
  @override
  Future<Either> getProductsByCategoryId(String categoryId) async{
    var returnedData = await sl<ProductFirebaseService>().getProductsByCategoryId(categoryId);
    return returnedData.fold(
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
  
  @override
  Future<Either<String, List<ProductEntity>>> getProductsByTitle(String title) async {
  final returnedData = await sl<ProductFirebaseService>().getProductsByTitle(title);

  return returnedData.fold(
    (error) {
      debugPrint('Repository error: $error');
      return Left(error);
    },
    (data) {
      final products = data.map((e) {
        try {
          final product = ProductModel.fromMap(e).toEntity();
          debugPrint('Mapped product: $product');
          return product;
        } catch (e) {
          debugPrint('Mapping error for data: $e');
          return null; 
        }
      }).whereType<ProductEntity>().toList();

      debugPrint('Final product list: $products');
      return Right(products);
    },
  );
}
}