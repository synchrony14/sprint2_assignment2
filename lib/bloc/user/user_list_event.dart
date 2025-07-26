part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserListEvent {}
