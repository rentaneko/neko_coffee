import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/cart.dart';

import '../../core/entities/topping.dart';
import '../../core/error/server_error.dart';

abstract interface class CartRepository {
  Future<Either<ServerError, CartItem>> addToCart({
    required String idProduct,
    required String iceType,
    required String variantType,
    required String sizeCup,
    required String sugarType,
    required List<String> toppings,
    required int quantity,
    required String id,
  });

  Future<Either<ServerError, List<Topping>>> getAllToppingById(String id);
  Future<Either<ServerError, List<CartItem>>> getListItemInCartById(String id);
}
