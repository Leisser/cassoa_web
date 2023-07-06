import 'dart:async';

import 'package:animated_flight_paths/animated_flight_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reusable_widgets/tille.dart';

class AnimatedFlightPathsExample extends StatefulWidget {
  const AnimatedFlightPathsExample({super.key});

  @override
  State<AnimatedFlightPathsExample> createState() =>
      _AnimatedFlightPathsExampleState();
}

class _AnimatedFlightPathsExampleState extends State<AnimatedFlightPathsExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  bool? isFirstTime;

  @override
  void initState() {
    super.initState();
    recordFistVisit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  void toToNextPage() {
    Timer(const Duration(seconds: 10), () {
      goToSignin();
    });
  }

  goToSignin() {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => const SignInPage(),
    //   ),
    //   ModalRoute.withName("/"),
    // );
    context.go('/signin');
  }

  recordFistVisit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool('isFirstTime', false);
    toToNextPage();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 1],
            colors: [Color(0xFF27163e), Color(0xFF432a72)],
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              const Center(child: Title1()),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .7,
                  child: _animatedFlightPaths),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _animatedFlightPaths => AnimatedFlightPaths(
        controller: controller,
        debugShowOffsetOnTap: false,
        flightSchedule: FlightSchedule(
          start: DateTime.parse('2023-01-01 00:00:00'),
          end: DateTime.parse('2023-01-01 23:59:00'),
          flights: flights,
        ),
        options: const FlightPathOptions(
          showLabels: true,
          fromEndpointColor: SynthwaveColors.yellow,
          toEndpointColor: SynthwaveColors.yellow,
          flightPathColor: SynthwaveColors.yellow,
          fromEndpointCurve: Curves.easeInOut,
          flightPathCurve: Curves.easeInOutSine,
          toEndpointCurve: Curves.easeInOut,
          flightPathStrokeWidth: 2,
          endpointRadius: 5,
          endpointToLabelSpacing: 12,
          endpointDotAlwaysVisible: false,
          endpointLabelAlwaysVisible: false,
          keepFlightPathsVisible: true,
          curveDepth: 0.5,
          endpointWeight: 0.2,
        ),
        child: const MapSvg(
          map: FlightMap.worldMercatorProjection,
          outlineColor: SynthwaveColors.pink,
          fillColor: SynthwaveColors.black,
        ),
      );
}

final flights = <Flight>[
  Flight(
    from: Cities.paris,
    to: Cities.tokyo,
    departureTime: DateTime.parse('2023-01-01 00:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 14:00:00'),
  ),
  Flight(
    from: Cities.sydney,
    to: Cities.capeTown,
    departureTime: DateTime.parse('2023-01-01 00:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 18:00:00'),
  ),
  Flight(
    from: Cities.buenosAires,
    to: Cities.losAngeles,
    departureTime: DateTime.parse('2023-01-01 06:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 21:00:00'),
  ),
  Flight(
    from: Cities.newYork,
    to: Cities.london,
    departureTime: DateTime.parse('2023-01-01 16:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 23:00:00'),
  ),
  Flight(
    from: Cities.cairo,
    to: Cities.london,
    departureTime: DateTime.parse('2023-01-01 17:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 23:00:00'),
  ),
  Flight(
    from: Cities.bangkok,
    to: Cities.london,
    departureTime: DateTime.parse('2023-01-01 10:00:00'),
    arrivalTime: DateTime.parse('2023-01-01 23:00:00'),
  ),
];

abstract class Cities {
  static final bangkok = FlightEndpoint(
    offset: const Offset(75, 65),
    label: const Label(text: 'Bangkok'),
  );

  static final buenosAires = FlightEndpoint(
    offset: const Offset(32, 87),
    label: const Label(text: 'Buenos Aires'),
  );

  static final cairo = FlightEndpoint(
    offset: const Offset(56, 58),
    label: const Label(text: 'Cairo'),
  );

  static final capeTown = FlightEndpoint(
    offset: const Offset(53.5, 86),
    label: const Label(text: 'Cape Town'),
  );

  static final losAngeles = FlightEndpoint(
    offset: const Offset(16, 54),
    label: const Label(text: 'Los Angeles'),
  );

  static final london = FlightEndpoint(
    offset: const Offset(48, 45),
    label: const Label(text: 'London'),
  );

  static final newYork = FlightEndpoint(
    offset: const Offset(28, 51),
    label: const Label(text: 'New York'),
  );

  static final paris = FlightEndpoint(
    offset: const Offset(49, 48),
    label: const Label(text: 'Paris'),
  );

  static final sydney = FlightEndpoint(
    offset: const Offset(89, 87),
    label: const Label(text: 'Sydney'),
  );

  static final tokyo = FlightEndpoint(
    offset: const Offset(86, 54),
    label: const Label(text: 'Tokyo'),
  );
}

abstract class SynthwaveColors {
  static const pink = Color(0xFF0FF11E);
  static const yellow = Color(0xFFfdfe43);
  static const blue = Color(0xFF74f7ff);
  static const black = Color(0xFF201130);
}

class Label extends StatelessWidget {
  const Label({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: SynthwaveColors.black,
        border: Border.all(
          color: SynthwaveColors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: SynthwaveColors.blue,
          fontSize: 14,
        ),
      ),
    );
  }
}
