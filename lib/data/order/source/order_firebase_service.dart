import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techstore/data/order/model/add_to_cart_req.dart';
import 'package:techstore/data/order/model/order_registration_req.dart';

abstract class OrderFirebaseService {

  Future<Either> addToCart( AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  Future<Either> orderRegistration(OrderRegistrationReq order);
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
  
  @override
  Future<Either> getCartProducts() async{
    try {
    var user = FirebaseAuth.instance.currentUser;
    var returnedData = await FirebaseFirestore.instance.collection(
      'Users'
    ).doc(user!.uid).collection("Cart").get();

    List<Map> products = [];
    for(var item in returnedData.docs) {
      var data = item.data();
      data.addAll({"id" : item.id});
      products.add(data);
    }
    return Right(products);
  } catch (e) {
    return const Left('Please try again');
  }
}

  @override
  Future<Either> removeCartProduct(String id) async{
    try {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(
      'Users'
    ).doc(user!.uid).collection("Cart").doc(
      id
    ).delete();

    return Right("Product was removed");
  } catch (e) {
    return const Left('Please try again');
  }
  }
  
  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async{
     try {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(
      'Users'
    ).doc(user!.uid).collection("Orders").add(
      order.toMap()
    );

    for(var item in order.products) {
       await FirebaseFirestore.instance.collection(
      'Users'
    ).doc(user.uid).collection("Cart").doc(item.id).delete();
    }
    return Right("Order placed successfully");
  } catch (e) {
    return const Left('Please try again');
  }
  }
}