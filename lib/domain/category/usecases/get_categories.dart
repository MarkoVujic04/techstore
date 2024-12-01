import 'package:dartz/dartz.dart';
import 'package:techstore/core/usecases/usecase.dart';
import 'package:techstore/domain/category/repository/category.dart';
import 'package:techstore/service_locator.dart';

class GetCategoriesUseCase implements Usecase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<CategoryRepository>().getCategories();
  }

}