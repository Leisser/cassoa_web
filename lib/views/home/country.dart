import 'package:flutter/material.dart';

class RegisterCountry extends StatefulWidget {
  const RegisterCountry({super.key});

  @override
  State<RegisterCountry> createState() => _RegisterCountryState();
}

class _RegisterCountryState extends State<RegisterCountry> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Country'),
    );
  }
}