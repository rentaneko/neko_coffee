import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/datasource/local/product.local.dart';
import 'package:neko_coffee/domain/datasource/remote/product_api.dart';
import 'package:neko_coffee/domain/repositories/product.repository.dart';

import '../../../core/network/connetion_checker.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ConnectionChecker connectionChecker;
  final ProductRemoteDataSource dataSource;
  final ProductLocalDataSource localSource;

  ProductRepositoryImpl(
      this.connectionChecker, this.dataSource, this.localSource);

  @override
  Future<Either<ServerError, List<Product>>> getAllProduct() async {
    try {
      if (!await connectionChecker.isConnected) {
        final product = localSource.loadProduct();

        product.sort((a, b) {
          if (a.isPromo && b.isPromo) return -1;

          if (!a.isPromo && b.isPromo) return 1;

          return a.price.compareTo(b.price);
        });

        return right(product);
      }
      final products = await dataSource.getAllProduct();
      return right(products);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }
}
