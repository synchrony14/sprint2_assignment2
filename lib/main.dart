import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_1_assignment/bloc/registration_bloc.dart';
import 'package:week_1_assignment/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}
