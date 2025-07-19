import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/bloc/registration_bloc.dart';
import 'package:week_1_assignment/bloc/registration_event.dart';
import 'package:week_1_assignment/bloc/registration_state.dart';
import 'package:week_1_assignment/presentation/pages/widgets/input_decoration.dart';
import 'package:week_1_assignment/presentation/pages/widgets/labeled_form_field.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class EmailPasswordPage extends StatefulWidget {
  const EmailPasswordPage({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<EmailPasswordPage> createState() => _EmailPasswordPageState();
}

class _EmailPasswordPageState extends State<EmailPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<RegistrationBloc>().state.user;
    _emailController = TextEditingController(text: user.email);
    _passwordController = TextEditingController(text: user.password);
    _confirmPasswordController = TextEditingController(text: user.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

//Main Body Section
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    IndicatorSection('${state.currentStep + 1} out of 3'),
                    const SizedBox(height: 16),
                    const SectionHeader('Email & Password'),
                    const SectionSubtext('Login information.'),
                    const SizedBox(height: 20),
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildConfirmPasswordField(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//Email Section
  Widget _buildEmailField() => LabeledFormField(
    label: 'Email Address',
    field: TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: boxInputDecoration(),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Email is required';
        final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          return re.hasMatch(v) ? null : 'Enter a valid email';
      },
      onChanged: (v) => context.read<RegistrationBloc>().add(UpdateEmail(v)),
    ),
  );

//Password Section
  Widget _buildPasswordField() => LabeledFormField(
    label: 'Password',
    field: TextFormField(
      controller: _passwordController,
      obscureText: _obscurePass,
      decoration: boxInputDecoration().copyWith(
        suffixIcon: IconButton(
          icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscurePass = !_obscurePass),
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Password is required';
        return v.length >= 8 ? null : 'Minimum 8 characters';
      },
      onChanged: (v) => context.read<RegistrationBloc>().add(UpdatePassword(v)),
    ),
  );

//Confirm PW Section
  Widget _buildConfirmPasswordField() => LabeledFormField(
    label: 'Confirm Password',
    field: TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPass,
      decoration: boxInputDecoration().copyWith(
        suffixIcon: IconButton(
          icon: Icon(_obscureConfirmPass ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscureConfirmPass = !_obscureConfirmPass),
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Confirm Password is required';
        return v == _passwordController.text ? null : 'Passwords do not match';
      },
    ),
  );
}
