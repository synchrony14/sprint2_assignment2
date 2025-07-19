import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/bloc/registration_event.dart';
import 'package:week_1_assignment/bloc/registration_state.dart';
import 'package:week_1_assignment/data/user_entity.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(): super(const RegistrationState(user: UserEntity(), currentStep: 0)) {

    on<UpdateFirstName>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(firstName: event.firstName)));
    });

    on<UpdateLastName>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(lastName: event.lastName)));
    });

    on<UpdateBirthDate>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(birthDate: event.birthDate, age: event.age)));
    });

    on<UpdateAge>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(age: event.age)));
    });

    on<UpdateBio>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(bio: event.bio)));
    });

    on<UpdateEmail>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(email: event.email)));
    });

    on<UpdatePassword>((event, emit) {
      emit(state.copyWith(user: state.user.copyWith(password: event.password)));
    });

    on<UpdateStep>((event, emit) {
      emit(state.copyWith(currentStep: event.step));
    });

    on<SubmitRegistration>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isSubmissionSuccess: false, errorMessage: null));
        try {
          await Future.delayed(const Duration(seconds: 1));
          emit(state.copyWith(isSubmitting: false, isSubmissionSuccess: true));
        } catch (e) {
          emit(state.copyWith(
            isSubmitting: false,
            isSubmissionSuccess: false,
            errorMessage: e.toString(),
          ));
        }
    });
  }
}
