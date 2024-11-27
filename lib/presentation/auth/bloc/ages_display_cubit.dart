import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/auth/usecases/get_ages_usecase.dart';
import 'package:techstore/presentation/auth/bloc/ages_display_state.dart';
import 'package:techstore/service_locator.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {

  AgesDisplayCubit() : super(AgesLoading());

  void displayAges() async {
    
    var returnedData = await sl<GetAgesUseCase>().call();

    returnedData.fold(
      (message) {
        emit(
          AgesLoadFailure(message: message)
        );
      },
      (data) {
        emit(
          AgesLoaded(ages: data)
        );
      }
    );

  }
}