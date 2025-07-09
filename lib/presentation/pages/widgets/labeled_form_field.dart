import 'package:flutter/material.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class LabeledFormField extends StatelessWidget {
  const LabeledFormField({
    super.key,
    required this.label,
    required this.field,
  });

  final String label;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        const SizedBox(height: 8),
        field,
        const SizedBox(height: 16),
      ],
    );
  }
}
