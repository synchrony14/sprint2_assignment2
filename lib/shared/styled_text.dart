import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Main Text Section
class StyledText extends StatelessWidget {
  const StyledText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

//Appbar Title Text Section
class AppbarTitleText extends StatelessWidget {
  const AppbarTitleText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//Card Text Section
class CardText extends StatelessWidget {
  const CardText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

//Indicator Text Section
class IndicatorSection extends StatelessWidget {
  const IndicatorSection(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        color: Colors.grey,
      ),
    );
  }
}

//Header Text Section
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//Subtext Section
class SectionSubtext extends StatelessWidget {
  const SectionSubtext(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.poppins(
        color: Colors.grey,
      ),
    );
  }
}

//Form Field Labels Section
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

//Label and Value Texts Section
class LabelValueText extends StatelessWidget {
  const LabelValueText({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(value,
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
