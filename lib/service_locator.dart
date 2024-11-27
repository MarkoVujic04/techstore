import 'package:get_it/get_it.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/auth/repository/auth_repository_impl.dart';
import 'package:techstore/data/auth/source/auth_firebase_service.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/domain/auth/usecases/get_ages_usecase.dart';
import 'package:techstore/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  //Services
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  //Usecases
  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

   sl.registerSingleton<GetAgesUseCase>(
    GetAgesUseCase()
  );
}