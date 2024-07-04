import 'package:dio/dio.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/models/cart.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../models/topping.model.dart';

abstract interface class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel item);
  Future<CartItemModel> updateCartItem(String id, int quantity, double total);
  Future<List<CartItemModel>> getListItemInCartById(String idProduct);
  Future<List<ToppingModel>> getAllToppingById(String id);
  Future<List<CartItemModel>> getAllItemInCart();
}

class CartRemoteDataSourcImpl implements CartRemoteDataSource {
  final SupabaseClient client;

  CartRemoteDataSourcImpl(this.client);

  @override
  Future<CartItemModel> addToCart(CartItemModel item) async {
    try {
      item.idUser = client.auth.currentUser!.id;
      item.id = const Uuid().v4().toString();
      final data = await client.from('cart').insert([item.toJson()]).select();
      return CartItemModel.fromJson(data.first);
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

  @override
  Future<CartItemModel> updateCartItem(
      String id, int quantity, double total) async {
    try {
      final result = await client
          .from('cart')
          .update({'quantity': quantity, 'total': total})
          .eq('id_user', client.auth.currentUser!.id)
          .eq('id', id)
          .select()
          .single();
      return CartItemModel.fromJson(result);
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<List<CartItemModel>> getAllItemInCart() async {
    try {
      final result = await client
          .from('cart')
          .select()
          .eq('id_user', client.auth.currentUser!.id);
      return result.map((e) => CartItemModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<List<ToppingModel>> getAllToppingById(String idCate) async {
    try {
      final result =
          await client.from('topping').select().eq('id_category', idCate);
      return result.map((e) => ToppingModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }
}
