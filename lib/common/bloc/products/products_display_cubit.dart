import 'package:flutter_bloc/flutter_bloc.dart';
import 'products_display_state.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final UseCase useCase;

  ProductsDisplayCubit({required this.useCase}) : super(ProductsInitialState());

  /// Display products based on the provided parameters.
  Future<void> displayProducts({required dynamic params}) async {
    emit(ProductsLoading());

    try {
      // Execute the use case.
      final returnedData = await useCase.call(params: params);

      // Handle the result.
      returnedData.fold(
        (error) {
          emit(LoadProductsFailure(errorMessage: error)); // Pass the error message.
        },
        (data) {
          emit(ProductsLoaded(products: data)); // Emit the loaded state with products.
        },
      );
    } catch (e) {
      emit(LoadProductsFailure(errorMessage: e.toString())); // Handle unexpected errors.
    }
  }

  /// Reset to the initial state.
  void displayInitial() {
    emit(ProductsInitialState());
  }
}
