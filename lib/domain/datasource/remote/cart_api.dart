import 'package:dio/dio.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/models/cart.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/topping.model.dart';

abstract interface class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel item);
  Future<List<ToppingModel>> getAllToppingById(String id);
  Future<List<CartItemModel>> getListItemInCartById(String idProduct);
}

class CartRemoteDataSourcImpl implements CartRemoteDataSource {
  final SupabaseClient client;

  CartRemoteDataSourcImpl(this.client);

  @override
  Future<CartItemModel> addToCart(CartItemModel item) async {
    try {
      item.idUser = client.auth.currentUser!.id;
      final data = await client.from('cart').insert([item.toJson()]).select();
      return CartItemModel.fromJson(data.first);
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<List<ToppingModel>> getAllToppingById(String id) async {
    try {
      final toppings =
          (await client.from('topping').select('*').eq('id_category', id))
              .map((e) => ToppingModel.fromJson(e))
              .toList();
      return toppings;
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<List<CartItemModel>> getListItemInCartById(String idProduct) async {
    try {
      final result = await client
          .from('cart')
          .select()
          .eq('id_user', client.auth.currentUser!.id)
          .eq('id_product', idProduct);
      return result.map((e) => CartItemModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }
}
