
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/order/entities/product_ordered.dart';
import 'package:techstore/domain/order/usecases/get_cart_products.dart';
import 'package:techstore/domain/order/usecases/remove_cart_product.dart';
import 'package:techstore/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:techstore/service_locator.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit(): super(CartProductsLoading());

  void displayCartProducts() async {

   var returnedData = await sl<GetCartProductsUseCase>().call();

    returnedData.fold(
      (error) {
        emit(LoadCartProductsFailure(errorMessage: error));
      },
      (data) {
        emit(CartProductsLoaded(products: data));
      }
    );
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
   emit(CartProductsLoading());
   var returnedData = await sl<RemoveCartUseCase>().call(
    params: product.id
   );

    returnedData.fold(
      (error) {
        emit(LoadCartProductsFailure(errorMessage: error));
      },
      (data) {
        displayCartProducts();
      }
    );
  }
}