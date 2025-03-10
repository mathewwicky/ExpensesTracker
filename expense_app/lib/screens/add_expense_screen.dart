import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/provider/category_provider.dart';
import 'package:expense_app/provider/expense_provider.dart';
import 'package:expense_app/provider/tag_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              //Text("Payee", style: TextStyle(fontSize: 24),),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount"),
                      SizedBox(height: 6),
                      TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: "Enter Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text("Payee"),
                      SizedBox(height: 6),
                      TextField(
                        controller: _payeeController,
                        decoration: InputDecoration(
                          hintText: "Payee Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text("Note"),
                      SizedBox(height: 6),
                      TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText: "Enter Note",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text("Date"),
                      SizedBox(height: 6),
                      TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          hintText: "Enter Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () {
                          _selectDate();
                        },
                      ),
                      SizedBox(height: 6),
                      Text("Category"),

                      Consumer<CategoryProvider>(
                        builder: (context, categoryProvider, child) {
                          return DropdownButtonFormField<String>(
                            value:
                                _categoryIdController.text.isNotEmpty
                                    ? _categoryIdController.text
                                    : null,
                            decoration: InputDecoration(
                              hintText: "Select Category",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items:
                                categoryProvider.categories.map((category) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        category
                                            .name, // You can use tag.id if needed
                                    child: Text(category.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _categoryIdController.text =
                                    value!; // Save selected tag
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(height: 6),
                      Text("Tag"),
                      SizedBox(height: 6),

                      Consumer<TagProvider>(
                        builder: (context, tagProvider, child) {
                          return DropdownButtonFormField<String>(
                            value:
                                _tagController.text.isNotEmpty
                                    ? _tagController.text
                                    : null,
                            decoration: InputDecoration(
                              hintText: "Select Tag",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items:
                                tagProvider.tags.map((tag) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        tag.name, // You can use tag.id if needed
                                    child: Text(tag.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _tagController.text =
                                    value!; // Save selected tag
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          minimumSize: Size(500, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blue,
                        ),

                        onPressed: () {
                          _saveExpense(context);
                        },
                        child: Text("Add Expense"),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // date picker in the add expense form
  Future<void> _selectDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != Null) {
      setState(() {
        _dateController.text = _pickedDate.toString().split(" ")[0];
      });
    }
  }

  void _saveExpense(BuildContext context) {
    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text),
      categoryId: _categoryIdController.text,
      payee: _payeeController.text,
      note: _noteController.text,
      date: DateTime.parse(_dateController.text),
      tag: _tagController.text,
    );

    Provider.of<ExpenseProvider>(context, listen: false).addExpenses(expense);
    // Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryIdController.dispose();
    _payeeController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
