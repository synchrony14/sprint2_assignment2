import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/details/widgets/card_details.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _DetailsAppBar(),
      body: _DetailsBackground(),
    );
  }
}

//Appbar Section
class _DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DetailsAppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1F1C2C),
      title: const StyledText('Details Screen'),
      centerTitle: true,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//Card Details Section
class _DetailsBackground extends StatelessWidget {
  const _DetailsBackground();
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
      child: const Center(
        child: CardDetails(),
      ),
    );
  }
}
