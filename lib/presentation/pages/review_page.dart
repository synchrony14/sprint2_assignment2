import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/pages/widgets/form_buttons.dart';
import 'package:week_1_assignment/shared/styled_text.dart';
import 'package:week_1_assignment/data/user_data.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBodySection(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: _buildButtonRow(context),
      ),
    );
  }

  //Main Body Section
  //ignore: non_constant_identifier_names
  Padding MainBodySection() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 20),
          _buildInfoSection(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  //Header Section
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Center(child: IndicatorSection('3 out of 3')),
        SizedBox(height: 16),
        SectionHeader('Review Information'),
        SectionSubtext('Please review all your information before you continue.'),
      ],
    );
  }

  //Info Details Section
  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueText(label: 'First Name', value: userData.firstName),
        LabelValueText(label: 'Last Name', value: userData.lastName),
        LabelValueText(
          label: 'Birthdate',
          value: userData.birthDate != null
              ? DateFormat('MM/dd/yyyy').format(userData.birthDate!)
              : '',
        ),
        LabelValueText(label: 'Age', value: '${userData.age}'),
        LabelValueText(label: 'Email', value: userData.email),
        const SizedBox(height: 40),
        LabelValueText(label: 'Bio - Describe yourself', value: userData.bio),
      ],
    );
  }

  //Buttons Section
  Widget _buildButtonRow(BuildContext context) {
    return ButtonRow(
      onBack: () => tabController.animateTo(1),
      onNext: () {
        FocusScope.of(context).unfocus();
        final dataJson = jsonEncode({
          "firstName": userData.firstName,
          "lastName": userData.lastName,
          "birthdate": userData.birthDate != null
              ? DateFormat('MM/dd/yyyy').format(userData.birthDate!)
              : '',
          "age": userData.age,
          "email": userData.email,
          "bio": userData.bio,
        });

        debugPrint(dataJson);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Complete')),
        );
      },
      nextText: 'Continue',
    );
  }
}
