import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:week_1_assignment/api_service.dart';
import 'package:week_1_assignment/data/user_entity.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final ApiService service;

  UserListBloc(this.service) : super(UserListInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserListLoading());
      try {
        final users = await service.getUsers();
        emit(UserListSuccess(users));
      } catch (e) {
        emit(UserListFailure('Failed to fetch users.'));
      }
    });
  }
}