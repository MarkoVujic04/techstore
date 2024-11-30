import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/auth/models/user_signin_req.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/service_locator.dart';

class SignInUseCase implements Usecase<Either, UserSigninReq>{
  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
  
}