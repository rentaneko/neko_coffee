part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

// core cannot depend on other feature
// other feature can depend on core

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  const AppUserLoggedIn(this.user);
}
