import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
  @override
  List<Object?> get props => [];
}

class UpdateFirstName extends RegistrationEvent{
  const UpdateFirstName(this.firstName);
  final String firstName;
  @override
  List<Object?> get props => [firstName];
}

class UpdateLastName extends RegistrationEvent{
  const UpdateLastName(this.lastName);
  final String lastName;
  @override
  List<Object?> get props => [lastName];
}

class UpdateBirthDate extends RegistrationEvent{
  const UpdateBirthDate(this.birthDate, this.age);
  final DateTime birthDate;
  final int age;
  @override
  List<Object?> get props => [birthDate, age];
}

class UpdateAge extends RegistrationEvent{
  const UpdateAge(this.age);
  final int age;
  @override
  List<Object?> get props => [age];
}

class UpdateBio extends RegistrationEvent{
  const UpdateBio(this.bio);
  final String bio;
  @override
  List<Object?> get props => [bio];
}

class UpdateEmail extends RegistrationEvent{
  const UpdateEmail(this.email);
  final String email;
  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends RegistrationEvent{
  const UpdatePassword(this.password);
  final String password;
  @override
  List<Object?> get props => [password];
}

class UpdateStep extends RegistrationEvent{
  const UpdateStep(this.step);
  final int step;
  @override
  List<Object?> get props => [step];
}

class SubmitRegistration extends RegistrationEvent{}
class ResetSubmissionStatus extends RegistrationEvent{}