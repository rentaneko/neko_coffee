import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:neko_coffee/core/common/cubit/app_user_cubit.dart';
import 'package:neko_coffee/core/network/connetion_checker.dart';
import 'package:neko_coffee/domain/datasource/local/product.local.dart';
import 'package:neko_coffee/domain/datasource/remote/auth_api.dart';
import 'package:neko_coffee/domain/datasource/remote/cart_api.dart';
import 'package:neko_coffee/domain/datasource/remote/product_api.dart';
import 'package:neko_coffee/domain/repositories/auth_repository.dart';
import 'package:neko_coffee/domain/repositories/cart.repository.dart';
import 'package:neko_coffee/domain/repositories/product.repository.dart';
import 'package:neko_coffee/domain/usecase/add_to_cart.dart';
import 'package:neko_coffee/domain/usecase/current_user.dart';
import 'package:neko_coffee/domain/usecase/get_all_product.dart';
import 'package:neko_coffee/domain/usecase/get_list_item_by_id.dart';
import 'package:neko_coffee/domain/usecase/get_topping_by_id.dart';
import 'package:neko_coffee/domain/usecase/logout_user.dart';
import 'package:neko_coffee/domain/usecase/usecase_login.dart';
import 'package:neko_coffee/domain/usecase/usecase_sign_up.dart';
import 'package:neko_coffee/features/auth/bloc/auth_bloc.dart';
import 'package:neko_coffee/features/auth/repository/auth_repository_impl.dart';
import 'package:neko_coffee/features/cart/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:neko_coffee/features/cart/bloc/cart/cart_bloc.dart';
import 'package:neko_coffee/features/cart/repository/cart.repo_impl.dart';
import 'package:neko_coffee/features/product/bloc/product_bloc.dart';
import 'package:neko_coffee/features/product/repository/product.repo_impl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secret.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
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

  Hive.defaultDirectory = (await getApplicationCacheDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

  _initAuth();
  _initProduct();
  _initCart();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteApi>(
      () => AuthRemoteApiImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
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

void _initProduct() {
  serviceLocator
        //data source
        ..registerFactory<ProductRemoteDataSource>(
            () => ProductRemoteDataSourceImpl(serviceLocator()))
        ..registerFactory<ProductLocalDataSource>(
            () => ProductLocalDataSourceImpl())

        // repository
        ..registerFactory<ProductRepository>(() => ProductRepositoryImpl(
            serviceLocator(), serviceLocator(), serviceLocator()))

        // usecase
        ..registerFactory(() => GetAllProduct(serviceLocator()))
        // bloc
        ..registerLazySingleton(() => ProductBloc(
              getAllProduct: serviceLocator(),
            ))

      //
      ;
}

void _initCart() {
  serviceLocator
        // data source (API for remote, local for local storage)
        ..registerFactory<CartRemoteDataSource>(
            () => CartRemoteDataSourcImpl(serviceLocator()))
        // repository
        ..registerFactory<CartRepository>(() => CartRepositoryImpl(
              serviceLocator(),
              serviceLocator(),
            ))
        //usecase
        ..registerFactory(() => AddToCart(serviceLocator()))
        ..registerFactory(() => GetToppingById(serviceLocator()))
        ..registerFactory(() => GetListItemCartById(serviceLocator()))
        // bloc
        ..registerLazySingleton(() => CartBloc(
              addToCart: serviceLocator(),
            ))
        ..registerLazySingleton(() => AddToCartBloc(
              getToppingById: serviceLocator(),
              addToCart: serviceLocator(),
              getListItem: serviceLocator(),
            ))

      //
      ;
}
