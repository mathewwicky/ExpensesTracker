import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:expense_app/models/Tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagProvider with ChangeNotifier {
  List<Tag> _tags = [];
  List<Tag> get tags => _tags;

  TagProvider() {
    _loadTagsFromStorage();
  }

  Future<void> _loadTagsFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTags = prefs.getString("tags");

    if (storedTags != null) {
      try {
        List<dynamic> decodedData = jsonDecode(storedTags);
        _tags =
            decodedData.map((item) => Tag.fromJson(item)).toList();
      } catch (e) {
        print("Error loading expenses: $e");
      }
    }
    notifyListeners();
  }

  // save Tags to sharedPreference

  Future<void> _savedTagsToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTags = jsonEncode(
      _tags.map((e) => e.toJson()).toList(),
    );
    await prefs.setString("tags", jsonTags);
  }

  void addTags(Tag tag) {
    _tags.add(tag);
    _savedTagsToStorage();
    notifyListeners();
  }

  void removeTag(String id) {
    _tags.removeWhere((tag) => tag.id == id);
    _savedTagsToStorage();
    notifyListeners();
  }
}
