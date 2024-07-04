import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/repositories/cart.repository.dart';

class AddToCart implements Usecase<CartItem, AddToCartParams> {
  final CartRepository cartRepository;

  AddToCart(this.cartRepository);
  @override
  Future<Either<ServerError, CartItem>> call(AddToCartParams params) async {
    return await cartRepository.addToCart(
      idProduct: params.idProduct,
      iceType: params.iceType,
      variantType: params.variantType,
      sizeCup: params.sizeCup,
      sugarType: params.sugarType,
      quantity: params.quantity,
      total: params.total,
    );
  }
}

class AddToCartParams {
  final String idProduct;
  final String iceType;
  final String variantType;
  final String sizeCup;
  final String sugarType;
  final int quantity;
  final double total;

  AddToCartParams({
    required this.idProduct,
    required this.iceType,
    required this.variantType,
    required this.sizeCup,
    required this.sugarType,
    required this.quantity,
    required this.total,
  });
}
