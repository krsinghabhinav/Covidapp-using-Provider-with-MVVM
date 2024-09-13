import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:covidapp/view/WorldStateScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorldStateScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: SizedBox(
                  height: 300,
                  width: 300, // Adjusted width for better visuals
                  child: Center(
                    child: Image.asset("assets/images/virus.png"),
                  ),
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              const SizedBox(height: 30), // Space between image and text
              const Text(
                "Covid-19\nTracker App",
                textAlign: TextAlign.center, // Center text
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
