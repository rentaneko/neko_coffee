import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/entities/topping.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/datasource/remote/cart_api.dart';
import 'package:neko_coffee/domain/models/cart.model.dart';
import 'package:neko_coffee/domain/repositories/cart.repository.dart';

import '../../../core/network/connetion_checker.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  final ConnectionChecker connectionChecker;

  CartRepositoryImpl(this.cartRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<ServerError, CartItem>> addToCart({
    required String idProduct,
    required String iceType,
    required String variantType,
    required String sizeCup,
    required String sugarType,
    required List<String> toppings,
    required int quantity,
    required String id,
  }) async {
    try {
      CartItemModel cartModel = CartItemModel(
        idProduct: idProduct,
        idTopping: toppings,
        iceType: iceType,
        variantType: variantType,
        sizeCup: sizeCup,
        sugarType: sugarType,
        quantity: quantity,
        id: id,
        idUser: '',
      );
      final result = await cartRemoteDataSource.addToCart(cartModel);
      return right(result);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }

  @override
  Future<Either<ServerError, List<Topping>>> getAllToppingById(
      String id) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(ServerError.network());
      }
      final toppings = await cartRemoteDataSource.getAllToppingById(id);
      return right(toppings);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }

  @override
  Future<Either<ServerError, List<CartItem>>> getListItemInCartById(
      String id) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(ServerError.network());
      }
      final result = await cartRemoteDataSource.getListItemInCartById(id);
      return right(result);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }
}
