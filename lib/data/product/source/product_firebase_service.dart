import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techstore/data/product/models/product.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

abstract class ProductFirebaseService {

  Future<Either> getTopSelling();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity productEntity);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {
  @override
  Future < Either > getTopSelling() async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
        'Products'
      ).where(
        'salesNumber',
        isGreaterThanOrEqualTo: 20
      ).get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
        'Please try again'
      );
    }
  }
  
  @override
  Future<Either> getProductsByCategoryId(String categoryId) async{
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
        'Products'
      ).where(
        'categoryId',
        isEqualTo: categoryId,
      ).get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
        'Please try again'
      );
    }
  }
  
  @override
Future<Either> getProductsByTitle(String title) async {
  try {
    var returnedData = await FirebaseFirestore.instance.collection(
      'Products'
    ).where(
      'title',
      isGreaterThanOrEqualTo: title,
    ).where(
      'title',
      isLessThan: title + '\uf8ff', // Ensures results starting with "title"
    ).get();

    return Right(returnedData.docs.map((e) => e.data()).toList());
  } catch (e) {
    return const Left('Please try again');
  }
}

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity productEntity) async{
    try {

      var user = FirebaseAuth.instance.currentUser;
      var products = await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user!.uid).collection("Favorites").where(
        "productId",isEqualTo: productEntity.productId,
      ).get();

      if(products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return const Right(false);
      }else {
        await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user.uid).collection("Favorites").add(
        productEntity.fromEntity().toMap(),
      );
      return const Right(true);
      }
    }catch(e) {
      return const Left("Please try again");
    }
  }
  
  @override
  Future<bool> isFavorite(String productId) async{
     try {

      var user = FirebaseAuth.instance.currentUser;
      var products = await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user!.uid).collection("Favorites").where(
        "productId",isEqualTo: productId,
      ).get();

      if(products.docs.isNotEmpty) {
        return true;
      }else {
        return false;
      }
    }catch(e) {
      return false;
    }
  }
  
  @override
  Future<Either> getFavoritesProducts() async{
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user!.uid).collection("Favorites").get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
        'Please try again'
      );
    }
  }


}