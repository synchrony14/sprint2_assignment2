import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/api_service.dart';
import 'package:week_1_assignment/bloc/registration/registration_bloc.dart';
import 'package:week_1_assignment/bloc/registration/registration_event.dart';
import 'package:week_1_assignment/bloc/registration/registration_state.dart';
import 'package:week_1_assignment/data/user_entity.dart';
import 'package:week_1_assignment/dio_client.dart';
import 'package:week_1_assignment/presentation/pages/email_password_page.dart';
import 'package:week_1_assignment/presentation/pages/personal_info_page.dart';
import 'package:week_1_assignment/presentation/pages/review_page.dart';
import 'package:week_1_assignment/presentation/pages/widgets/form_buttons.dart';
import 'package:week_1_assignment/presentation/screens/home/home_screen.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin {
  bool _ready = false;
  late final TabController _tabController;
  late final RegistrationBloc _registrationBloc;
  final _formKey = GlobalKey<FormState>();
  late final ApiService _service;

  @override
  void initState() {
    super.initState();
    _registrationBloc = context.read<RegistrationBloc>();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_){
      if (!mounted) return;
      setState(() => _ready = true);
      final initialStep = _registrationBloc.state.currentStep;
      if(_tabController.index != initialStep){
        _tabController.index = initialStep;
      }
    }
  );
    _service = ApiService(DioClient.create());
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
        listener: (_, __) {
          if (!mounted) return;
          _dismissLoader();   
          _showSuccessDialog();       
        },
        child: Scaffold(
          appBar: appBarSection(),
          body: mainBodySection(),
        ),
      ),
    );
  }

//Appbar Section
  AppBar appBarSection() {
    return AppBar(
      title: const SectionHeader('Registration'), 
      centerTitle: true
    );
  }

//Main Body Section
  Column mainBodySection() {
    return Column(
      children: [
      const Divider(height: 1),
        Expanded(
          child: Builder(
            builder: (_) {
              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PersonalInfoPage(tabController: _tabController, formKey: _formKey),
                  EmailPasswordPage(tabController: _tabController),
                  ReviewPage(tabController: _tabController, service: _service),
                ],
              );
            },
          ),
        ),

//Main Body Content Section
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (_, state) {
              if (!_ready || state.currentStep == 2) {
                return const SizedBox.shrink();
              }

            return ButtonRow(
              showBack: state.currentStep > 0,
              nextText: state.currentStep == 0 ? 'Next' : 'Continue',
              onBack: () => _goToStep(state.currentStep - 1),
              onNext: () => _handleNext(state.currentStep),
            );
          },
        ),
      ),
    ],
  );
}

//Onback Function Section
  void _goToStep(int step){
    if (step < 0 || step > 2) return;
      FocusScope.of(context).unfocus();
      _tabController.animateTo(step);
      _registrationBloc.add(UpdateStep(step));
    }

//Handler Section
  void _handleNext(int step) {
    FocusScope.of(context).unfocus();
    if (step == 0 && (_formKey.currentState?.validate() ?? false)) {
      _tabController.animateTo(1);
      _registrationBloc.add(UpdateStep(1));
    } else if (step == 1) {
      _tabController.animateTo(2);
      _registrationBloc.add(UpdateStep(2));
    } else {
      _submitWithRetry();
    }
  }

//Submit with Retry Section
  void _submitWithRetry() async {
    final user = _registrationBloc.state.user;
    _showLoader();
    
    try {
      await _service.triggerError();
      throw Exception('Simulated Failuer');
    } catch (_) {
      if (!mounted) return;
      _dismissLoader();
      _showRetryDialog(user);
    }
  }

//Retry Section
  void _showRetryDialog(UserEntity user) {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to submit registration. Retry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancel')
          ),
          TextButton(
            onPressed: () {
            Navigator.pop(context);
            _retryRegistration(user);
          }, 
            child: const Text('Retry')
          ),
        ],
      ),
    );
  }

//Retry Reg Section
  Future<void> _retryRegistration(UserEntity user) async {
  _showLoader();
  try {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    _dismissLoader();
    _showSuccessAfterRetryDialog();
  } catch (error) {
    if (!mounted) return;
    _dismissLoader();
    _showRetryDialog(user);
  }
}

//Success Dialog Section
  void _showSuccessAfterRetryDialog(){
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (_) => AlertDialog(
        title: const Text('Success!'),
        content: const Text('Registration is Successful!'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false);
            }, 
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

//Show Loader Section
  void _showLoader() {
    if (!mounted) return;
    showDialog(context: context, barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

//Dismiss Loader
  void _dismissLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }

//Success Dialog Section
  void _showSuccessDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Registration complete!'),
        actions: [
          TextButton(
            onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false,
            );
          }, child: const Text('OK')),
        ],
      ),
    );
  }
}
