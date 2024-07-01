import 'package:fpdart/src/either.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';

import '../repositories/cart.repository.dart';

class GetListItemCartById
    implements Usecase<List<CartItem>, GetListItemCartParams> {
  final CartRepository cartRepository;

  GetListItemCartById(this.cartRepository);

  @override
  Future<Either<ServerError, List<CartItem>>> call(
      GetListItemCartParams params) async {
    return await cartRepository.getListItemInCartById(params.idProduct);
  }
}

class GetListItemCartParams {
  String idProduct;
  GetListItemCartParams({required this.idProduct});
}
