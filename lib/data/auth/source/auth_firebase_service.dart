import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techstore/data/auth/models/user_creation_req.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';

abstract class AuthFirebaseService {

  Future<Either> signup(UserCreationReq user);
  Future<Either> getAges(); 
  Future<Either> signin(UserSigninReq user); 
  Future<Either> resetPasswordEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  @override
  Future<Either> signup(UserCreationReq user) async{
    try {

      var returnedData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      await FirebaseFirestore.instance.collection("Users").doc(
        returnedData.user!.uid,
      ).set(
        {
          "email" : user.email,
          "firstName" : user.firstName,
          "lastName" : user.lastName,
          "gender" : user.gender,
          "age" : user.age,
        }
      );

      return const Right(
        "Sign Up Successful"
      );

    } on FirebaseAuthException catch(e) {

        String message = "";

        if(e.code == "weak-password") {
          message = "The password is too weak";
        } else if(e.code == "email is already used") {
          message = "An account with the same email already exists";
        }

      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection('Ages').get();
      return Right(
        returnedData.docs
      );
    } catch (e) {
      return const Left(
        'Try again'
      );
    }
  }
  
  @override
  Future<Either> signin(UserSigninReq user) async {
     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!
      );
      return const Right(
        'Sign in was successfull'
      );

    } on FirebaseAuthException catch(e){
      String message = '';
      
      if(e.code == 'invalid-email') {
        message = 'Not user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for this user';
      }
      
      return Left(message);
    }
  }
  
  @override
  Future<Either> resetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(
        "The reset email has been sent"
      );
    } catch(e) {
      return const Left(
        "Try again please"
      );
    }
  }
  
  @override
  Future<bool> isLoggedIn() async {
    if(FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    else {
      return false;
    }
  }
  
  @override
  Future<Either> getUser() async{
    try { 
    var currentUser = FirebaseAuth.instance.currentUser;
    var userData = await FirebaseFirestore.instance.collection("Users").doc(
      currentUser?.uid
    ).get().then((value) => value.data());
    return Right(
      userData,
    );
    } catch(e) {
      return const Left(
        "Try again please"
      );
    }
  }


}