import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/homepage.dart';
import 'signin.dart';
import 'splash_page.dart';

class CheckIfSignedIn extends StatefulWidget {
  const CheckIfSignedIn({super.key});

  @override
  State<CheckIfSignedIn> createState() => _CheckIfSignedInState();
}

class _CheckIfSignedInState extends State<CheckIfSignedIn> {
  String? userId, token;
  bool? isFirstTime;

  checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid') ?? '';
      token = prefs.getString('authToken') ?? '';
      isFirstTime = prefs.getBool('isFirstTime') ?? true;
    });
    if (userId!.isNotEmpty && token!.isNotEmpty) {
      goToHome();
    } else {
      ifNotSignedIn();
    }
  }

  goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      ModalRoute.withName("/"),
    );
  }

  goToSignUp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignInPage(),
      ),
      ModalRoute.withName("/"),
    );
  }

  goToSplash() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const AnimatedFlightPathsExample(),
      ),
      ModalRoute.withName("/"),
    );
  }

  ifNotSignedIn() {
    if (isFirstTime == true) {
      goToSplash();
    } else {
      goToSignUp();
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF432a72),
      ),
    );
  }
}
