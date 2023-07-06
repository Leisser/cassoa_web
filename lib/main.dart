import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/auth/export_auth.dart';
import 'views/home/export_home.dart';
import 'package:url_strategy/url_strategy.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // httpOverrides();
  runApp(const CassoaTraveller());
}

// httpOverrides() async {
//   HttpProxyOverride httpProxyOverride =
//       await HttpProxyOverride.createHttpProxy();
//   HttpOverrides.global = httpProxyOverride;
// }

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CheckIfSignedIn();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: 'details',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return const DetailsScreen();
      //     },
      //   ),
      // ],
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
    // GoRoute(
    //   path: '/signup',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SignUpPage();
    //   },
    // ),
    GoRoute(
      path: '/splashscreen',
      builder: (BuildContext context, GoRouterState state) {
        return const AnimatedFlightPathsExample();
      },
    ),
  ],
);

class CassoaTraveller extends StatelessWidget {
  const CassoaTraveller({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerConfig: _router,
    );
  }
}
