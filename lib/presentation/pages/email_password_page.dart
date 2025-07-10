import 'package:flutter/material.dart';
import 'package:week_1_assignment/shared/styled_text.dart';
import 'package:week_1_assignment/data/user_data.dart';
import 'widgets/input_decoration.dart';
import 'widgets/form_buttons.dart';
import 'widgets/labeled_form_field.dart';

class EmailPasswordPage extends StatefulWidget {
  const EmailPasswordPage({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<EmailPasswordPage> createState() => _EmailPasswordPageState();
}

class _EmailPasswordPageState extends State<EmailPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  @override
  void initState() {
    super.initState();
    _emailController.text = userData.email;
    _passwordController.text = userData.password;
    _confirmPasswordController.text = userData.password;
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
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const IndicatorSection('2 out of 3'),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: ButtonRow(
          onBack: () => widget.tabController.animateTo(0),
          onNext: () {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              userData.email = _emailController.text;
              userData.password = _passwordController.text;
              _formKey.currentState!.save();
              widget.tabController.animateTo(2);
            }
          },
          nextText: 'Review',
        ),
      ),
    );
  }

//Email Section
  Widget _buildEmailField() {
    return LabeledFormField(
      label: 'Email Address',
      field: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: boxInputDecoration(),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
      ),
    );
  }

//Password Section
  Widget _buildPasswordField() {
    return LabeledFormField(
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
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Password is required';
          }
          if (value.length < 8) {
            return 'Minimum 8 characters';
          }
          return null;
        },
      ),
    );
  }

//Confirm PW Section
  Widget _buildConfirmPasswordField() {
    return LabeledFormField(
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
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Confirm Password is required';
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}

