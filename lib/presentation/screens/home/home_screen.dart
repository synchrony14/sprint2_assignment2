import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/home/widgets/card_content.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _HomeAppBar(),
      body: _HomeBackground(),
    );
  }
}

//Appbar Section
class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1F1C2C),
      title: const StyledText('Profile Screen'),
      centerTitle: true,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//Gradient Background Section
class _HomeBackground extends StatelessWidget {
  const _HomeBackground();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const CardContent(),
    );
  }
}
