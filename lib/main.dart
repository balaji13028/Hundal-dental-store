import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hundalstore/Home_page.dart';
import 'package:hundalstore/unable_load.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Color(0xffffd333), // status bar color
  ));
  runApp(const MyApp());
}

final routemaster = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/unableToLoad',
      builder: (context, state) => const UnableToLoad(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final AppLinksDeepLink _appLinksDeepLink =
  //     AppLinksDeepLink.instance; // Initialize AppLinksDeepLink instance

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // _appLinksDeepLink
    //     .initDeepLinks(); // Initialize deep links when the app starts
    return MaterialApp.router(
      title: 'Hundal Dental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: routemaster,
      // home: const HomePage(),
    );
  }
}
