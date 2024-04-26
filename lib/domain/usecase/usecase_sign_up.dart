import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/core/entities/user.dart';
import 'package:neko_coffee/domain/repositories/auth_repository.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<ServerError, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      fullname: params.fullname,
      phone: params.phone,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String phone;
  final String fullname;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.phone,
    required this.fullname,
  });
}
