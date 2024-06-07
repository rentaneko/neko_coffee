import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/repositories/product.repository.dart';

class GetAllProduct implements Usecase<List<Product>, NoParams> {
  final ProductRepository productRepository;

  GetAllProduct(this.productRepository);

  @override
  Future<Either<ServerError, List<Product>>> call(NoParams params) async {
    return await productRepository.getAllProduct();
  }
}
