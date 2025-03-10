import 'package:flutter/material.dart';
import 'package:expense_app/models/category.dart';
import 'package:expense_app/provider/category_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Category")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
    context: context,
    builder: (context) => AddCategoryDialog(),
  );
        },
        child: Icon(Icons.add),
      ),

      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          final categories = categoryProvider.categories;
          if (categories.isEmpty) {
            return Center(child: Text("No categories added yet"));
          }
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final Category category = categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                child: ListTile(
                  title: Text(category.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     // Text(category.name),
                      IconButton(
                        onPressed: () {
                          _confirmDelete(context, category.id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String categoryId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text(
              "Are you sure you want to delete this category?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<CategoryProvider>(
                    context,
                    listen: false,
                  ).removeCategory(categoryId);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Category"),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Add categoey"),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () {
            final categoryName = _nameController.text;
            if (categoryName.isNotEmpty) {
              //logic here
              _saveCategory(context);
              Navigator.of(context).pop();
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }

  void _saveCategory(BuildContext context) {
    final category = Category(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
    );

    Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).addCategories(category);
  }
}
