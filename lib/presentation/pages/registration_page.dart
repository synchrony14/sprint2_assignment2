import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/bloc/registration_bloc.dart';
import 'package:week_1_assignment/bloc/registration_event.dart';
import 'package:week_1_assignment/bloc/registration_state.dart';
import 'package:week_1_assignment/presentation/pages/email_password_page.dart';
import 'package:week_1_assignment/presentation/pages/personal_info_page.dart';
import 'package:week_1_assignment/presentation/pages/review_page.dart';
import 'package:week_1_assignment/presentation/pages/widgets/form_buttons.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final RegistrationBloc _registrationBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _registrationBloc = RegistrationBloc();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          _registrationBloc.add(UpdateStep(_tabController.index));
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _registrationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registrationBloc,
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (prev, curr) => !prev.isSubmissionSuccess && curr.isSubmissionSuccess,
        listener: (context, state) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Registration Complete'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _tabController.animateTo(0);
                    _registrationBloc.add(UpdateStep(0));
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          appBar: AppBarSection(),
          body: MainBodySection(),
        ),
      ),
    );
  }

//Appbar Section
  //ignore: non_constant_identifier_names
  AppBar AppBarSection() {
    return AppBar(
      title: const SectionHeader('Registration'),
      centerTitle: true,
    );
  }

//Main Body Section
  //ignore: non_constant_identifier_names
  Column MainBodySection() {
    return Column(
      children: [
        const Divider(height: 1),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PersonalInfoPage(tabController: _tabController, formKey: _formKey),
              EmailPasswordPage(tabController: _tabController),
              ReviewPage(tabController: _tabController),
                ],
              ),
            ),
            
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              return ButtonRow(
                showBack: state.currentStep > 0,
                nextText: state.currentStep == 0
                  ? 'Next'
                  : state.currentStep == 1
                  ? 'Review'
                  : 'Continue',
                onBack: () {
                  final prev = state.currentStep - 1;
                    if (prev >= 0) {
                      FocusScope.of(context).unfocus();
                      _tabController.animateTo(prev);
                      _registrationBloc.add(UpdateStep(prev));
                    }
                  },
                onNext: () {
                  if (state.currentStep == 0) {
                    if (_formKey.currentState?.validate() ?? false) {
                      FocusScope.of(context).unfocus();
                      _tabController.animateTo(1);
                      _registrationBloc.add(UpdateStep(1));
                    }
                  } else if (state.currentStep == 1) {
                    FocusScope.of(context).unfocus();
                    _tabController.animateTo(2);
                    _registrationBloc.add(UpdateStep(2));
                  } else {
                    FocusScope.of(context).unfocus();
                    _registrationBloc.add(SubmitRegistration());
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

