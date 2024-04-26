import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<ServerError, SuccessType>> call(Params params);
}

class NoParams {}
