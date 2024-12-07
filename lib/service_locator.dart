import 'package:get_it/get_it.dart';
import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/data/auth/repository/auth_repository_impl.dart';
import 'package:techstore/data/auth/source/auth_firebase_service.dart';
import 'package:techstore/data/category/repository/category.dart';
import 'package:techstore/data/category/source/category_firebase_service.dart';
import 'package:techstore/data/product/repository/product_repository_impl.dart';
import 'package:techstore/data/product/source/product_firebase_service.dart';
import 'package:techstore/domain/auth/repository/auth.dart';
import 'package:techstore/domain/auth/usecases/get_ages_usecase.dart';
import 'package:techstore/domain/auth/usecases/get_user_usecase.dart';
import 'package:techstore/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:techstore/domain/auth/usecases/reset_password.dart';
import 'package:techstore/domain/auth/usecases/signin.dart';
import 'package:techstore/domain/auth/usecases/signup.dart';
import 'package:techstore/domain/category/repository/category.dart';
import 'package:techstore/domain/category/usecases/get_categories.dart';
import 'package:techstore/domain/product/repository/product.dart';
import 'package:techstore/domain/product/usecases/get_products_by_categoryId.dart';
import 'package:techstore/domain/product/usecases/get_products_by_title.dart';
import 'package:techstore/domain/product/usecases/get_top_selling.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  //Services
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<CategoryFirebaseService>(
    CategoryFirebaseServiceImpl()
  );

  sl.registerSingleton<ProductFirebaseService>(
    ProductFirebaseServiceImpl()
  );

  //Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl()
  );

  sl.registerSingleton<ProductRepository>(
    ProductRepositoryImpl()
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

  sl.registerSingleton<GetTopSellingUseCase>(
    GetTopSellingUseCase()
  );

  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
    GetProductsByCategoryIdUseCase()
  );

  sl.registerSingleton<GetProductsByTitleUseCase>(
    GetProductsByTitleUseCase()
  );

}