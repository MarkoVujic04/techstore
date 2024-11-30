import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/service_locator.dart';

class GetUserUseCase implements Usecase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }

}