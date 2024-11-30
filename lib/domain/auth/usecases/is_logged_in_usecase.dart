import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/service_locator.dart';

class IsLoggedInUseCase implements Usecase<bool,dynamic> {


  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }

}