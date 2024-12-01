import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/auth/usecases/get_user_usecase.dart';
import 'package:techstore/presentation/home/bloc/user_info_display_state.dart';
import 'package:techstore/service_locator.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  
  UserInfoDisplayCubit() : super(UserInfoLoading());

  void displayUserInfo() async {

    var returnedData = await sl<GetUserUseCase>().call();
    returnedData.fold(
      (error){
        emit(
          LoadUserInfoFailure()
        );
      }, 
      (data){
        emit(
          UserInfoLoaded(
            user: data
          )
        );
      }
    );
  }
}