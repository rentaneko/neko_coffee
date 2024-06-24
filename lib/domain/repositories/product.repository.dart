import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/product.dart';

import '../../core/error/server_error.dart';

abstract interface class ProductRepository {
  Future<Either<ServerError, List<Product>>> getAllProduct();
}
