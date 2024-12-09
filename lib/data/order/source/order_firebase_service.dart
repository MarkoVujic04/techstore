import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';

abstract class OrderFirebaseService {

  Future<Either> addToCart( AddToCartReq addToCartReq);
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async{
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("Users").doc(user!.uid)
      .collection("Cart").add(
        addToCartReq.toMap()
      );
      return Right("Adding to cart was a success");
    } catch(e) {
      return Left("Adding to cart was not a success");
    }
  }

}