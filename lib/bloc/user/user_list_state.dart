part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}
class UserListLoading extends UserListState {}
class UserListSuccess extends UserListState {
  final List<UserEntity> users;
  UserListSuccess(this.users);

  @override
  List<Object> get props => [users];
}

class UserListFailure extends UserListState {
  final String message;

  UserListFailure(this.message);

  @override
  List<Object> get props => [message];
}
