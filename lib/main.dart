import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/routes/app_page.dart';
import 'package:neko_coffee/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://jwkhdpftwjndgkzrczjy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3a2hkcGZ0d2puZGdrenJjemp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY1MDk0MjgsImV4cCI6MjAyMjA4NTQyOH0.XgoNXmbMPflOSpoilbyhRsn6C1CRuQSe6fymz-1sJZs',
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      autoRefreshToken: true,
    ),
  );

  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.blocer(context)],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) => SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.teal),
            navigatorObservers: [AppPages.observer],
            initialRoute: APP_ROUTE,
            onGenerateRoute: AppPages.generateRouteSettings,
          ),
        ),
      ),
    );
  }
}
