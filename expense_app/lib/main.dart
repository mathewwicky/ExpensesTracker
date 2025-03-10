import 'package:flutter/material.dart';
import 'package:expense_app/provider/category_provider.dart';
import 'package:expense_app/provider/tag_provider.dart';
import 'package:expense_app/screens/add_category_screen.dart';
import 'package:expense_app/screens/add_tag_screen.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/screens/expensescreen.dart';
import 'package:expense_app/screens/homescreens.dart';
import 'package:expense_app/screens/settings.dart';
import 'package:expense_app/screens/add_expense_screen.dart';
import 'package:expense_app/provider/expense_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
        ChangeNotifierProvider(create: (context) => CategoryProvider(),),
        ChangeNotifierProvider(create: (context) => TagProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Homescreen(),
          '/expensescreen': (context) => Expensescreen(),
          '/settingscreen': (context) => Settingscreen(),
          '/addexpense': (context) => AddExpenseScreen(),
          '/managecategory': (context) => AddCategoryScreen(),
          '/managetags': (context) => TagManagementScreen(),
        },
      ),
    );
  }
}
