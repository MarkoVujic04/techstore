import 'package:techstore/common/bloc/products/products_display_cubit.dart';
import 'package:techstore/domain/product/repository/product.dart';
import 'package:techstore/service_locator.dart';

class IsFavoriteUseCase implements UseCase<bool,String> {


  @override
  Future<bool> call({String ? params}) async {
    return await sl<ProductRepository>().isFavorite(params!);
  }

}