import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_app/models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    _loadExpensesFromStorage();
  }

  // Load expenses from SharedPreferences
  Future<void> _loadExpensesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedExpenses = prefs.getString('expenses');

    if (storedExpenses != null) {
      try {
        List<dynamic> decodedData = jsonDecode(storedExpenses);
        _expenses = decodedData.map((item) => Expense.fromJson(item)).toList();
      } catch (e) {
        print("Error loading expenses: $e");
      }
    }
    notifyListeners();
  }

  // Save expenses to SharedPreferences
  Future<void> _saveExpensesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonExpenses = jsonEncode(_expenses.map((e) => e.toJson()).toList());
    await prefs.setString('expenses', jsonExpenses);
  }

  void addExpenses(Expense expense) {
    _expenses.add(expense);
    _saveExpensesToStorage();
    notifyListeners();
  }

  void addOrUpdateExpense(Expense expense) {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }
    _saveExpensesToStorage();
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    _saveExpensesToStorage();
    notifyListeners();
  }
//debug to print out the preference storage
  void debugPrintStoredExpenses() async {
  final prefs = await SharedPreferences.getInstance();
  final storedExpenses = prefs.getString("expenses");

  if (storedExpenses != null) {
    print("Stored Expenses JSON:\n$storedExpenses");
  } else {
    print("No expenses found in SharedPreferences.");
  }
}

}
