import 'package:dartz/dartz.dart';
import 'package:techstore/data/auth/models/user_creation_req.dart';
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
}