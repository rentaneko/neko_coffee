import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/repositories/auth_repository.dart';
import '../../core/entities/user.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<ServerError, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
