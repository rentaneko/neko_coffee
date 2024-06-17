import 'package:dio/dio.dart';
import 'package:neko_coffee/domain/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/server_error.dart';
import '../../models/category.model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct();
  Future<CategoryModel> getCategoryById(String id);
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

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final category = await client.from('category').select('*').eq('id', id);
      return CategoryModel.fromJson(category.first);
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }
}
