import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/service_locator.dart';

class ResetPasswordUseCase implements Usecase<Either, String>{
  @override
  Future<Either> call({String ? params}) async {
    return sl<AuthRepository>().resetPasswordEmail(params!);
  }
  
}