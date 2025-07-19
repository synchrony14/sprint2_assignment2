import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_1_assignment/bloc/registration_bloc.dart';
import 'package:week_1_assignment/data/user_entity.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainBodySection(context),
    );
  }

//Main Body Section
  Widget _mainBodySection(BuildContext context) {
    final user = context.watch<RegistrationBloc>().state.user;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 20),
          _buildInfoSection(user),
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

//Info Section
  Widget _buildInfoSection(UserEntity user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueText(label: 'First Name', value: user.firstName),
        LabelValueText(label: 'Last Name', value: user.lastName),
        LabelValueText(
          label: 'Birthdate',
          value: user.birthDate != null
              ? DateFormat('MM/dd/yyyy').format(user.birthDate!)
              : '',
        ),
        LabelValueText(label: 'Age', value: '${user.age}'),
        LabelValueText(label: 'Email', value: user.email),
        const SizedBox(height: 40),
        LabelValueText(label: 'Bio - Describe yourself', value: user.bio),
      ],
    );
  }
}


