import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_1_assignment/presentation/pages/widgets/form_buttons.dart';
import 'package:week_1_assignment/presentation/pages/widgets/input_decoration.dart';
import 'package:week_1_assignment/presentation/pages/widgets/labeled_form_field.dart';
import 'package:week_1_assignment/shared/styled_text.dart';
import 'package:week_1_assignment/data/user_data.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key, required this.tabController});
  final TabController tabController;
  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();

//Date Picker Section
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      int computedAge = DateTime.now().year - picked.year;
      if (computedAge > 99) computedAge = 99;
      setState(() {
        userData.birthDate = picked;
        _birthDateController.text = DateFormat('MM/dd/yyyy').format(picked);
        userData.age = DateTime.now().year - picked.year;
        _ageController.text = userData.age.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.text = userData.firstName;
    _lastNameController.text = userData.lastName;
    if (userData.birthDate != null) {
      _birthDateController.text = DateFormat('MM/dd/yyyy').format(userData.birthDate!);
      _ageController.text = userData.age.toString();
    }
    _bioController.text = userData.bio;
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

//Main Body Section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const IndicatorSection('1 out of 3'),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: PrimaryButton(
          text: 'Next',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              userData.firstName = _firstNameController.text;
              userData.lastName = _lastNameController.text;
              userData.bio = _bioController.text;
              _formKey.currentState!.save();
              widget.tabController.animateTo(1);
            }
          },
        ),
      ),
    );
  }

//First Name Section
  Widget _buildFirstNameField() {
    return LabeledFormField(
      label: 'First Name',
      field: TextFormField(
        controller: _firstNameController,
        decoration: boxInputDecoration(),
        validator: (value) =>
          (value == null || value.trim().isEmpty)
            ? 'First Name is required'
            : !_isTitleCase(value)
              ? 'Use Title Case (e.g. John)'
              : null,
      ),
    );
  }

//Last Name Section
  Widget _buildLastNameField() {
    return LabeledFormField(
      label: 'Last Name',
      field: TextFormField(
        controller: _lastNameController,
        decoration: boxInputDecoration(),
        validator: (value) =>
          (value == null || value.trim().isEmpty)
            ? 'Last Name is required'
            : !_isTitleCase(value)
              ? 'Use Title Case (e.g. Doe)'
              : null,
      ),
    );
  }

//Bday and Age Section
  Widget _buildBirthdateAndAgeRow() {
    return Row(
      children: [
  //Birthdate Section
        Expanded(
          flex: 3,
          child: LabeledFormField(
            label: 'Birthdate',
            field: TextFormField(
              controller: _birthDateController,
              decoration: boxInputDecoration(hintText: 'MM/DD/YYYY'),
              readOnly: true,
              onTap: _selectDate,
              validator: (value) => value!.isEmpty ? 'Birthdate is required' : null,
            ),
          ),
        ),
        const SizedBox(width: 16),
  //Age Section
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
        decoration: boxInputDecoration(),
        maxLines: 5,
        validator: (value) =>
          (value == null || value.trim().isEmpty)
            ? 'Bio is required'
            : !_isTitleCase(value)
              ? 'Use Title Case for your bio'
              : null,
      ),
    );
  }

//Title Case Function Section
  bool _isTitleCase(String input) {
    final words = input.trim().split(RegExp(r'\s+'));
    return words.every((word) => 
      word.isNotEmpty && 
      word[0] == 
      word[0].toUpperCase() && 
      word.substring(1) == 
      word.substring(1).toLowerCase());
  }
}

