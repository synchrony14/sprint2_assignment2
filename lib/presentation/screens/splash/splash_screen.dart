import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/home/home_screen.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SplashBackground(),
    );
  }
}

//Main Content Section
  class _SplashBackground extends StatelessWidget {
    const _SplashBackground();
    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 68, 157, 229), Color.fromARGB(255, 35, 121, 192)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: _SplashContent(),
        ),
      );
    }
  }

//Text Content Section
  class _SplashContent extends StatelessWidget {
    const _SplashContent();
    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          StyledText(
            text: 'Sprint 2',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          StyledText(
            text: 'Assignment 1',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      );
    }
  }
