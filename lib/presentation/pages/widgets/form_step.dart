import 'package:flutter/material.dart';
import 'package:week_1_assignment/shared/styled_button.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class FormStep extends StatelessWidget {
  const FormStep({
    super.key,
    required this.title,
    required this.description,
    required this.fields,
    required this.onNext,
    this.onBack,
    this.isReviewStep = false,
  });

  final String title;
  final String description;
  final List<Widget> fields;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isReviewStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(
          text: title,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        StyledText(
          text: description,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        const SizedBox(height: 32),
        ...fields,
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onBack != null)
              StyledButton(
                text: 'Back',
                onPressed: onBack!,
              ),
            const SizedBox(width: 20),
            StyledButton(
              text: isReviewStep 
                ? 'Continue' 
                : 'Next',
              onPressed: onNext,
            ),
          ],
        ),
      ],
    );
  }
}
