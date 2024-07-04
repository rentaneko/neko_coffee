import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import '../repositories/cart.repository.dart';

class UpdateCartItem implements Usecase<CartItem, UpdateCartItemParams> {
  final CartRepository cartRepository;

  UpdateCartItem(this.cartRepository);
  @override
  Future<Either<ServerError, CartItem>> call(
      UpdateCartItemParams params) async {
    return await cartRepository.updateCartItem(
      id: params.id,
      quantity: params.quantity,
      total: params.total,
    );
  }
}

class UpdateCartItemParams {
  final String id;
  final int quantity;
  final double total;
  UpdateCartItemParams(
      {required this.id, required this.quantity, required this.total});
}
