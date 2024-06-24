import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/topping.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/repositories/cart.repository.dart';

class GetToppingById implements Usecase<List<Topping>, GetToppingByIdParams> {
  final CartRepository cartRepository;

  GetToppingById(this.cartRepository);
  @override
  Future<Either<ServerError, List<Topping>>> call(
      GetToppingByIdParams params) async {
    return await cartRepository.getAllToppingById(params.id);
  }
}

class GetToppingByIdParams {
  final String id;

  GetToppingByIdParams({required this.id});
}
