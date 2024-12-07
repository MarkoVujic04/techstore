import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class ProductFirebaseService {

  Future<Either> getTopSelling();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
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


}