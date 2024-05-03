import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';

import '../repositories/auth_repository.dart';

class LogoutUser implements Usecase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUser(this.authRepository);

  @override
  Future<Either<ServerError, void>> call(NoParams params) async {
    return await authRepository.userLogout();
  }
}
