import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_1_assignment/api_service.dart';
import 'package:week_1_assignment/bloc/registration/registration_bloc.dart';
import 'package:week_1_assignment/bloc/registration/registration_event.dart';
import 'package:week_1_assignment/data/user_entity.dart';
import 'package:week_1_assignment/presentation/pages/widgets/form_buttons.dart';
import 'package:week_1_assignment/presentation/screens/user%20list/user_list_screen.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.tabController, required this.service});

  final TabController tabController;
  final ApiService service;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<RegistrationBloc>().state.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            _buildInfoSection(user),
            const SizedBox(height: 40),
          ],
        ),
      ),

//Buttons Section
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: ButtonRow(
          showBack: true,
          nextText: 'Review',
          onBack: () {
            tabController.animateTo(1);
            context.read<RegistrationBloc>().add(const UpdateStep(1));
          },
          onNext: () => _submitWithRetry(context, user),
        ),
      ),
    );
  }

//Retry Submission Section
  void _submitWithRetry(BuildContext context, UserEntity user) async {
    _showLoader(context);
    try {
      await service.triggerError();
      throw Exception('Simulated failure');
    } catch (_) {
      _dismissLoader(context);
      _showRetryDialog(context, user);
    }
  }

//Retry Dialog Section
  void _showRetryDialog(BuildContext context, UserEntity user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to submit registration. Retry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _retryRegistration(context, user);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

//Retry Registration Section
  Future<void> _retryRegistration(BuildContext context, UserEntity user) async {
    _showLoader(context);
    try {
      await Future.delayed(const Duration(seconds: 1));
      _dismissLoader(context);
      _showSuccessDialog(context);
    } catch (_) {
      _dismissLoader(context);
      _showRetryDialog(context, user);
    }
  }

//Success Dialog Section
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Success!'),
        content: const Text('Registration is Successful!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const UserListScreen()), (_) => false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

//Loaders Section
  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
  void _dismissLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
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
