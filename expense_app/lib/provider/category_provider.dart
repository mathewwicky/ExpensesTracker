import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:expense_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  CategoryProvider() {
    _loadCategoriesFromStorage();
  }

  Future<void> _loadCategoriesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCategories = prefs.getString("categories");

    if (storedCategories != null) {
      try {
        List<dynamic> decodedData = jsonDecode(storedCategories);
        _categories =
            decodedData.map((item) => Category.fromJson(item)).toList();
      } catch (e) {
        print("Error loading expenses: $e");
      }
    }
    notifyListeners();
  }

  // save categories to sharedPreference

  Future<void> _savedCategoriesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonCategories = jsonEncode(
      _categories.map((e) => e.toJson()).toList(),
    );
    await prefs.setString("categories", jsonCategories);
  }

  void addCategories(Category category) {
    _categories.add(category);
    _savedCategoriesToStorage();
    notifyListeners();
  }

  void removeCategory(String id) {
    _categories.removeWhere((category) => category.id == id);
    _savedCategoriesToStorage();
    notifyListeners();
  }
}
