import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/entities/topping.dart';
import '../../core/error/server_error.dart';

abstract interface class CartRepository {
  Future<Either<ServerError, CartItem>> addToCart({
    required String idProduct,
    required String iceType,
    required String variantType,
    required String sizeCup,
    required String sugarType,
    required int quantity,
    required double total,
  });

  Future<Either<ServerError, List<CartItem>>> getListItemInCartById(String id);

  Future<Either<ServerError, CartItem>> updateCartItem(
      {required String id, required int quantity, required double total});

  Future<Either<ServerError, List<Topping>>> getAllToppingById(
      {required String idCate});
}
