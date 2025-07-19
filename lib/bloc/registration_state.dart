import 'package:equatable/equatable.dart';
import 'package:week_1_assignment/data/user_entity.dart';

class RegistrationState extends Equatable {
  final UserEntity user;
  final int currentStep;
  final bool isSubmissionSuccess;
  final bool isSubmitting;
  final String? errorMessage;

  const RegistrationState({
    required this.user,
    required this.currentStep,
    this.isSubmissionSuccess = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    UserEntity? user,
    int? currentStep,
    bool? isSubmissionSuccess,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return RegistrationState(
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
      isSubmissionSuccess: isSubmissionSuccess ?? this.isSubmissionSuccess,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, currentStep, isSubmissionSuccess, isSubmitting, errorMessage];
}
