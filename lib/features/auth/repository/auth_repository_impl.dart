import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/api/auth_api.dart';
import 'package:neko_coffee/core/entities/user.dart';
import 'package:neko_coffee/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteApi authDataSourceApi;

  AuthRepositoryImpl(this.authDataSourceApi);

  @override
  Future<Either<ServerError, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authDataSourceApi.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<ServerError, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullname,
    required String phone,
  }) async {
    return _getUser(
      () async => await authDataSourceApi.signUpWithEmailPassword(
        email: email,
        password: password,
        phone: phone,
        fullname: fullname,
      ),
    );
  }

  Future<Either<ServerError, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (authException) {
      return left(
        ServerError.custom(
          msg: authException.message,
          statusCode: int.parse(authException.statusCode!),
        ),
      );
    } on ServerError catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<ServerError, User>> currentUser() async {
    try {
      final user = await authDataSourceApi.getCurrentUserData();
      if (user == null) {
        return left(ServerError.custom(msg: 'User not logged in'));
      }
      return right(user);
    } on ServerError catch (e) {
      return left(ServerError.custom(msg: e.message));
    }
  }

  @override
  Future<Either<ServerError, User?>> userLogout() async {
    try {
      await authDataSourceApi.userLogout();
      return right(null);
    } on ServerError catch (e) {
      return left(e);
    }
  }
}
