import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_1_assignment/bloc/registration/registration_bloc.dart';
import 'package:week_1_assignment/bloc/registration/registration_event.dart';
import 'package:week_1_assignment/bloc/registration/registration_state.dart';
import 'package:week_1_assignment/presentation/pages/widgets/input_decoration.dart';
import 'package:week_1_assignment/presentation/pages/widgets/labeled_form_field.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key, required this.tabController, required this.formKey});

  final TabController tabController;
  final GlobalKey<FormState> formKey;

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _ageController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final user = context.read<RegistrationBloc>().state.user;

    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _birthDateController = TextEditingController(
      text: user.birthDate != null
          ? DateFormat('MM/dd/yyyy').format(user.birthDate!)
          : '',
    );
    _ageController = TextEditingController(text: user.age.toString());
    _bioController = TextEditingController(text: user.bio);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

//Date Picker Section
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      int computedAge = DateTime.now().year - picked.year;
      if (computedAge > 99) computedAge = 99;

      context.read<RegistrationBloc>().add(UpdateBirthDate(picked, computedAge));

      _birthDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      _ageController.text = computedAge.toString();
    }
  }

//Main Body Section
  @override
    Widget build(BuildContext context) {
      return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return SizedBox.expand(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: widget.formKey,
                    child: ListView(
                      children: [
                        IndicatorSection('${state.currentStep + 1} out of 3'),
                        const SizedBox(height: 16),
                        const SectionHeader('Personal Information'),
                        const SectionSubtext('Input your personal information. All fields are required.'),
                        const SizedBox(height: 40),
                        _buildFirstNameField(),
                        _buildLastNameField(),
                        _buildBirthdateAndAgeRow(),
                        _buildBioField(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

//Firstname Section
  Widget _buildFirstNameField() {
    return LabeledFormField(
      label: 'First Name',
      field: TextFormField(
        controller: _firstNameController,
        decoration: boxInputDecoration(),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'First Name is required';
          if (!_isTitleCase(value)) return 'Use Title Case (e.g. John)';
          return null;
        },
        onChanged: (value) {
          context.read<RegistrationBloc>().add(UpdateFirstName(value));
        },
      ),
    );
  }

//Lastname Section
  Widget _buildLastNameField() {
    return LabeledFormField(
      label: 'Last Name',
      field: TextFormField(
        controller: _lastNameController,
        decoration: boxInputDecoration(),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Last Name is required';
          if (!_isTitleCase(value)) return 'Use Title Case (e.g. Doe)';
          return null;
        },
        onChanged: (value) {
          context.read<RegistrationBloc>().add(UpdateLastName(value));
        },
      ),
    );
  }

//Bday and Age Section
  Widget _buildBirthdateAndAgeRow() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: LabeledFormField(
            label: 'Birthdate',
            field: TextFormField(
              controller: _birthDateController,
              readOnly: true,
              onTap: _selectDate,
              decoration: boxInputDecoration(hintText: 'MM/DD/YYYY'),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Birthdate is required' : null,
            ),
          ),
        ),

        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: LabeledFormField(
            label: 'Age',
            field: TextFormField(
              controller: _ageController,
              enabled: false,
              decoration: boxInputDecoration(),
            ),
          ),
        ),
      ],
    );
  }

//Bio Section
  Widget _buildBioField() {
    return LabeledFormField(
      label: 'Bio - Describe yourself',
      field: TextFormField(
        controller: _bioController,
        maxLines: 5,
        decoration: boxInputDecoration(),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Bio is required';
          if (!_isTitleCase(value)) return 'Use Title Case for your bio';
          return null;
        },
        onChanged: (value) {
          context.read<RegistrationBloc>().add(UpdateBio(value));
        },
      ),
    );
  }

//Title Case Section
  bool _isTitleCase(String input) {
    final words = input.trim().split(RegExp(r'\s+'));
    return words.every((word) =>
        word.isNotEmpty &&
        word[0] == word[0].toUpperCase() &&
        word.substring(1) == word.substring(1).toLowerCase());
  }
}

