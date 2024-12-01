import 'package:get_it/get_it.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/auth/repository/auth_repository_impl.dart';
import 'package:techstore/data/auth/source/auth_firebase_service.dart';
import 'package:techstore/data/category/repository/category.dart';
import 'package:techstore/data/category/source/category_firebase_service.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/domain/auth/usecases/get_ages_usecase.dart';
import 'package:techstore/domain/auth/usecases/get_user_usecase.dart';
import 'package:techstore/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:techstore/domain/auth/usecases/reset_password.dart';
import 'package:techstore/domain/auth/usecases/signin.dart';
import 'package:techstore/domain/auth/usecases/signup.dart';
import 'package:techstore/domain/category/repository/category.dart';
import 'package:techstore/domain/category/usecases/get_categories.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  //Services
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<CategoryFirebaseService>(
    CategoryFirebaseServiceImpl()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl()
  );

  //Usecases
  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

   sl.registerSingleton<GetAgesUseCase>(
    GetAgesUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

  sl.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase()
  );

  sl.registerSingleton<IsLoggedInUseCase>(
    IsLoggedInUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
  );

  sl.registerSingleton<GetCategoriesUseCase>(
    GetCategoriesUseCase()
  );
}