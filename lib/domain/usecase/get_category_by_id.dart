import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/category.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';

import '../repositories/product.repository.dart';

class GetCategoryById implements Usecase<Category, GetCategoryByIdParams> {
  final ProductRepository productRepository;

  GetCategoryById(this.productRepository);
  @override
  Future<Either<ServerError, Category>> call(
      GetCategoryByIdParams params) async {
    return await productRepository.getCategoryById(params.id);
  }
}

class GetCategoryByIdParams {
  final String id;

  GetCategoryByIdParams({required this.id});
}
