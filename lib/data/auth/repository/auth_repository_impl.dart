import 'package:dartz/dartz.dart';
import 'package:techstore/data/auth/models/user.dart';
import 'package:techstore/data/auth/models/user_creation_req.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';
import 'package:techstore/data/auth/source/auth_firebase_service.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signup(UserCreationReq user) async {
    return sl<AuthFirebaseService>().signup(user);
  }
  
   @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signin(UserSigninReq user) async {
    return await sl<AuthFirebaseService>().signin(user);
  }
  
  @override
  Future<Either> resetPasswordEmail(String email) async {
    return await sl<AuthFirebaseService>().resetPasswordEmail(email);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }
  
  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    return user.fold(
      (error) {
        return Left(error);
      }, 
      (data) {
        return Right(
          UserModel.fromMap(data).toEntity(),
        );
      }
    );
  }
  

}