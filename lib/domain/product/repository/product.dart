import 'package:dartz/dartz.dart';

abstract class ProductRepository {

  Future<Either> getTopSelling();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
}