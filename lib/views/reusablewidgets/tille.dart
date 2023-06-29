import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../auth/splash_page.dart';

class Title1 extends StatelessWidget {
  final Color? color;
  const Title1({super.key, this.color = SynthwaveColors.blue});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Civil Aviation Safety and Security Oversight Agency'.toUpperCase(),
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color!,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }
}
