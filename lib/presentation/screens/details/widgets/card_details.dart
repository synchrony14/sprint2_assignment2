import 'package:flutter/material.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return const _GradientCardContainer(
      child: _CardContent(),
    );
  }
}

//Gradient Color Section
class _GradientCardContainer extends StatelessWidget {
  final Widget child;
  const _GradientCardContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1824),Color(0xFF6E6A83)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

//Card Details Section
class _CardContent extends StatelessWidget {
  const _CardContent();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        StyledText('Name: JB Garcia'),
        SizedBox(height: 8),
        StyledText('Role: Flutter Developer'),
        SizedBox(height: 8),
        StyledText('Bio: Loves building apps with beautiful UI'),
        SizedBox(height: 20),
        _BackButton(),
      ],
    );
  }
}

//Button Section
class _BackButton extends StatelessWidget {
  const _BackButton();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Back to Home'),
    );
  }
}
