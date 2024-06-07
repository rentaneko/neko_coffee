import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/cubit/app_user_cubit.dart';
import 'package:neko_coffee/core/routes/my_routes.dart';
import 'package:neko_coffee/core/routes/route_name.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/features/product/bloc/product_bloc.dart';
import 'package:neko_coffee/init_dependencies.dart';
import 'features/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ProductBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 470),
      builder: (context, child) => const SafeArea(
        child: MaterialApp(
          color: AppPallete.light,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MyRoutes.generateRoute,
          initialRoute: RoutesName.splashPath,
        ),
      ),
    );
  }
}
