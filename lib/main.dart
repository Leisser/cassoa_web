import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_proxy_override/http_proxy_override.dart';
import 'views/auth/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  httpOverrides();
  runApp(const CassoaTraveller());
}

httpOverrides() async {
  HttpProxyOverride httpProxyOverride =
      await HttpProxyOverride.createHttpProxy();
  HttpOverrides.global = httpProxyOverride;
}

class CassoaTraveller extends StatelessWidget {
  const CassoaTraveller({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const CheckIfSignedIn(),
    );
  }
}
