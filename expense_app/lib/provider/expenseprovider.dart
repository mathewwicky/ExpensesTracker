import 'dart:convert';

import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ExpenseProvider with ChangeNotifier{

  final LocalStorage storage;

  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider(this.storage){
    _loadExpensesFromStorage();
  }

void _loadExpensesFromStorage() {

var storedExpenses = storage.getItem('expenses');

try{
List<dynamic> decodedData = storedExpenses is String ? 
jsonDecode(storedExpenses)
:storedExpenses;

_expenses = decodedData
.map((item) => Expense.fromJson(item as Map<String, dynamic>)).toList();

}catch(e){
  print("Error loading expenses: $e");
}

notifyListeners();
}
  
void _saveExpensesToStorage(){
 storage.setItem('expenses', jsonEncode(_expenses.map((e) => e.toJson()).toList()));
}

void addExpenses(Expense expense){
  _expenses.add(expense);
  _saveExpensesToStorage();
  notifyListeners();
}

void addOrUpdataExpense(Expense expense){
  int index = _expenses.indexWhere((e) => e.id == expense.id);

if(index != -1){
_expenses[index] = expense;
}else{
  _expenses.add(expense);

}
_saveExpensesToStorage();
notifyListeners();
}

void removeExpense(String id){
  _expenses.removeWhere((expense)=> expense.id== id);
  _saveExpensesToStorage();
  notifyListeners();
}
}