import 'package:get_it/get_it.dart';
import 'package:neko_coffee/core/common/cubit/app_user_cubit.dart';
import 'package:neko_coffee/domain/api/auth_api.dart';
import 'package:neko_coffee/domain/api/blog_api.dart';
import 'package:neko_coffee/domain/repositories/auth_repository.dart';
import 'package:neko_coffee/domain/repositories/blog_repository.dart';
import 'package:neko_coffee/domain/usecase/current_user.dart';
import 'package:neko_coffee/domain/usecase/get_all_blog.dart';
import 'package:neko_coffee/domain/usecase/logout_user.dart';
import 'package:neko_coffee/domain/usecase/upload_blog.dart';
import 'package:neko_coffee/domain/usecase/usecase_login.dart';
import 'package:neko_coffee/domain/usecase/usecase_sign_up.dart';
import 'package:neko_coffee/features/auth/bloc/auth_bloc.dart';
import 'package:neko_coffee/features/auth/repository/auth_repository_impl.dart';
import 'package:neko_coffee/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:neko_coffee/features/blog/repository/blog_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secret.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      autoRefreshToken: true,
    ),
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteApi>(
      () => AuthRemoteApiImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerFactory(() => LogoutUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      logoutUser: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator
    //data source
    ..registerFactory<BlogApi>(() => BlogApiImpl(serviceLocator()))
    // repository
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(serviceLocator()))
    // usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlog(serviceLocator()))
    //bloc
    ..registerLazySingleton(() => BlogBloc(
          getAllBlog: serviceLocator(),
          uploadBlog: serviceLocator(),
        ));
}
