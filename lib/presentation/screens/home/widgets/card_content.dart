import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/api_service.dart';
import 'package:week_1_assignment/bloc/registration/registration_bloc.dart';
import 'package:week_1_assignment/bloc/user/user_list_bloc.dart';
import 'package:week_1_assignment/presentation/screens/user%20list/user_list_screen.dart';
import 'package:week_1_assignment/shared/styled_button.dart';
import 'package:week_1_assignment/shared/styled_text.dart';
import '../../../pages/registration_page.dart' as reg; 

class CardContent extends StatelessWidget {
  const CardContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _CardContentColumn(),
    );
  }
}

//Main Body Section
  class _CardContentColumn extends StatelessWidget {
    const _CardContentColumn();
    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _ProfileCard(),
        ],
      );
    }
  }

//Main Card Section
  class _ProfileCard extends StatelessWidget {
    const _ProfileCard();
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: 360,
        height: 450,
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(28),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 50, 139, 212), Color.fromARGB(255, 12, 79, 134)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(32),
            child: const _ProfileCardBody(),
          ),
        ),
      );
    }
  }

//Card Content Section
  class _ProfileCardBody extends StatelessWidget {
    const _ProfileCardBody();
    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _ProfileAvatar(),
          SizedBox(height: 16),
          _ProfileInfo(),
          SizedBox(height: 20),
          _RegisterButton(),
          SizedBox(height: 12),
          _ViewUserListButton(),
        ],
      );
    }
  }

//Avatar Section
  class _ProfileAvatar extends StatelessWidget {
    const _ProfileAvatar();
    @override
    Widget build(BuildContext context) {
      return const CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
      );
    }
  }

//Info Section
  class _ProfileInfo extends StatelessWidget {
    const _ProfileInfo();
    @override
    Widget build(BuildContext context) {
      return Column(
        children: const [
          CardText(text: 'JB Garcia'),
          CardText(text: 'Flutter Developer'),
        ],
      );
    }
  }

//Register Button Section
  class _RegisterButton extends StatelessWidget {
    const _RegisterButton();
    @override
    Widget build(BuildContext context) {
      return StyledButton(
        text: 'Register',
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_)=> RegistrationBloc(),
                child: const reg.RegistrationPage(),
              ), 
            ),
          );
        },
      );
    }
  }

//View User List Button Section
  class _ViewUserListButton extends StatelessWidget {
    const _ViewUserListButton();
    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => UserListBloc(ApiService(Dio())),
        child: _ButtonWithBloc(),
      );
    }
  }

//Bloc Button Section
class _ButtonWithBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {
        if (state is UserListLoading) {
          _showLoader(context);
        } else {
          _dismissLoader(context);
        }

        if (state is UserListSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const UserListScreen()),
          );
        }

        if (state is UserListFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return StyledButton(
          text: 'View Users',
          onPressed: () {
            context.read<UserListBloc>().add(FetchUsers());
          },
        );
      },
    );
  }

//Loaders Section
  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _dismissLoader(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}