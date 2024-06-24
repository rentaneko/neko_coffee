import 'package:dio/dio.dart';
import 'package:neko_coffee/domain/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/server_error.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final SupabaseClient client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final products = (await client.from('product').select('*'))
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return products;
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }
}
