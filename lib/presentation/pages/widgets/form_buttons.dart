import 'package:flutter/material.dart';

//Primary Button Section
  class PrimaryButton extends StatelessWidget {
    const PrimaryButton({super.key, required this.text, required this.onPressed, this.color});

    final String text;
    final VoidCallback onPressed;
    final Color? color;

    @override
    Widget build(BuildContext context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blue,
        ),
        onPressed: onPressed,
        child: Text(text,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      );
    }
  }

//Row Buttons Section
  class ButtonRow extends StatelessWidget {
    const ButtonRow({super.key, required this.onBack, required this.onNext, this.nextText = 'Next', this.showBack = false});

    final VoidCallback onBack;
    final VoidCallback onNext;
    final String nextText;
    final bool showBack;

    @override
    Widget build(BuildContext context) {
      return Row(
        children: [
          if (showBack) ...[
            Expanded(
              child: PrimaryButton(
                text: 'Back',
                color: Colors.grey,
                onPressed: onBack,
              ),
            ),
            const SizedBox(width: 16),
          ],
          
          Expanded(
            child: PrimaryButton(
              text: nextText,
              onPressed: onNext,
            ),
          ),
        ],
      );
    }
  }
