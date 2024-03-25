import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ScreenUtil.ensureScreenSize();
  // await Supabase.initialize(
  //   url: 'https://jwkhdpftwjndgkzrczjy.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3a2hkcGZ0d2puZGdrenJjemp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY1MDk0MjgsImV4cCI6MjAyMjA4NTQyOH0.XgoNXmbMPflOSpoilbyhRsn6C1CRuQSe6fymz-1sJZs',
  //   realtimeClientOptions: const RealtimeClientOptions(
  //     logLevel: RealtimeLogLevel.info,
  //   ),
  //   authOptions: const FlutterAuthClientOptions(
  //     authFlowType: AuthFlowType.pkce,
  //     autoRefreshToken: true,
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    // return MultiBlocProvider(
    //   providers: [...AppPages.blocer(context)],
    //   child: ScreenUtilInit(
    //     designSize: const Size(393, 852),
    //     builder: (context, child) => SafeArea(
    //       child: MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(primaryColor: Colors.teal),
    //         navigatorObservers: [AppPages.observer],
    //         initialRoute: SPLASH_ROUTE,
    //         onGenerateRoute: AppPages.generateRouteSettings,
    //       ),
    //     ),
    //   ),
    // );
  }
}
