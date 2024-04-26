import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/user.dart';

import '../../core/error/server_error.dart';

abstract interface class AuthRepository {
  Future<Either<ServerError, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullname,
    required String phone,
  });

  Future<Either<ServerError, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<ServerError, User>> currentUser();
}
