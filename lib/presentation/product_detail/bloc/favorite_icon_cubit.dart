import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';
import 'package:techstore/domain/product/usecases/add_or_remove_favorite_product.dart';
import 'package:techstore/domain/product/usecases/is_favorite.dart';
import 'package:techstore/service_locator.dart';

class FavoriteIconCubit extends Cubit<bool>{
  FavoriteIconCubit() : super(false);

  void isFavorite(String productId) async {
    var result = await sl<IsFavoriteUseCase>().call(
      params: productId
    );
    emit(result);
  }

  void onTap(ProductEntity product) async {
    var result = await sl<AddOrRemoveFavoriteProductUseCase>().call(
      params: product,
    );
    result.fold(
      (error) {}, 
      (data) {
        emit(data);
      }
    );
  }
}