// import 'package:expense_app/provider/expenseprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:expense_app/model/expense.dart';

// class CategoryManagementScreen extends StatelessWidget {
//   const CategoryManagementScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Manage Categories")),
//       body: Consumer<ExpenseProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             itemCount: provider.categories.length,
//             itemBuilder: (context, index) {
//               final category = provider.categories[index];
//               return ListTile(
//                 title: Text(category.name),
//                 trailing: IconButton(
//                   onPressed: () {
//                     provider.removeCategory(category.id);
//                   },
//                   icon: Icon(Icons.delete),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         _showAddCategoryDialog(context);
//       },
//       child: Icon(Icons.add),
//       tooltip: "Add Category",),
//     );
//   }
//   void _showAddCategoryDialog(BuildContext context) {
//     final TextEditingController _categoryNameController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Category'),
//           content: TextField(
//             controller: _categoryNameController,
//             decoration: InputDecoration(labelText: 'Category Name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final category = ExpenseCategory(
//                   id: DateTime.now().millisecondsSinceEpoch.toString(),
//                   name: _categoryNameController.text,
//                 );
//                 Provider.of<ExpenseProvider>(context, listen: false).addCategory(category);
//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
