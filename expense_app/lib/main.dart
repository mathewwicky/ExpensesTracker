import 'package:expense_app/screens/expensescreen.dart';
import 'package:expense_app/screens/homescreen.dart';
import 'package:expense_app/screens/settingscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{
               '/': (context) => Homescreen(),
               '/expensescreen': (context) => Expensescreen(),
               '/settingscreen': (context) => Settingscreen(),
               
      },
    );
  }
}