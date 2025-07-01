import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/home/home_screen.dart';

void main(){
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}