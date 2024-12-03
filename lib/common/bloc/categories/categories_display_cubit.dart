import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/common/bloc/categories/categories_display_state.dart';
import 'package:techstore/domain/category/usecases/get_categories.dart';
import 'package:techstore/service_locator.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState>{

  CategoriesDisplayCubit() : super(CategoriesLoading());

  void displayCategories() async {

    var returnedData = await sl<GetCategoriesUseCase>().call();

    returnedData.fold(
      (error) {
        emit(
          LoadCategoryFailure(),
        );
      }, 
      (data) {
        emit(
          CategoriesLoaded(categories: data),
        );
      }
    );
  }
}