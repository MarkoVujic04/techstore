import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:techstore/presentation/splash/bloc/splash_state.dart';
import 'package:techstore/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async{
    await Future.delayed(const Duration(seconds: 2));
    var isLoggedIN = await sl<IsLoggedInUseCase>().call();
    if(isLoggedIN == true) {
      emit(Authenticated());
    }
    else {
      emit(Unauthenticated());
    }
  }
}
