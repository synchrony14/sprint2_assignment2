import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    required this.text,
    required this.onPressed,
    this.fontSize = 16.0,
    this.color = Colors.blue,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
