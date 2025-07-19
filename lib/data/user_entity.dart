import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final int age;
  final String bio;
  final String email;
  final String password;

  const UserEntity({
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    this.age = 0,
    this.bio = '',
    this.email = '',
    this.password = '',
  });

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    int? age,
    String? bio,
    String? email,
    String? password, 
    int? step,
  }) {
    return UserEntity(
      firstName: firstName?? this.firstName,
      lastName: lastName?? this.lastName,
      birthDate: birthDate?? this.birthDate,
      age: age?? this.age,
      bio: bio?? this.bio,
      email: email?? this.email,
      password: password?? this.password,
    );
  }
  
  @override
  List<Object?> get props => [firstName, lastName, birthDate, age, bio, email, password];
}