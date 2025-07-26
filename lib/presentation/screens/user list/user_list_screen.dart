import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/api_service.dart';
import 'package:week_1_assignment/bloc/user/user_list_bloc.dart';
import 'package:week_1_assignment/presentation/screens/home/home_screen.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ApiService(Dio());
    return BlocProvider(
      create: (_) => UserListBloc(service)..add(FetchUsers()),
      child: Scaffold(
        appBar: appBarSection(context),
        body: mainBodySection(),
      ),
    );
  }

//Appbar Section
  AppBar appBarSection(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        },
      ),
      title: const AppbarTitleText('User List'),
      centerTitle: true,
    );
  }

//Main Body Section
  BlocBuilder<UserListBloc, UserListState> mainBodySection() {
    return BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) { 
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserListFailure) {
            return Center(child: Text(state.message));
          }
          if (state is UserListSuccess) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (_, idx) {
                final user = state.users[idx];
                return ListTile(
                  title: SectionSubtext('${user.firstName} ${user.lastName}'),
                  subtitle: SectionSubtext(user.email),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      );
  }
}