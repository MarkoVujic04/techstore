import 'package:dartz/dartz.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

abstract class ProductRepository {

  Future<Either> getTopSelling();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity productEntity);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}