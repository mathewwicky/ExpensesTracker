import 'package:flutter/material.dart';

class AddExpensescreen extends StatefulWidget {
  const AddExpensescreen({super.key});

  @override
  State<AddExpensescreen> createState() => _AddExpensescreenState();
}

class _AddExpensescreenState extends State<AddExpensescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Container(child: Column(children: [
        
            SizedBox(height: 10),
            //Text("Payee", style: TextStyle(fontSize: 24),),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              child: Padding(padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 6),
                   Text("Payee"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Payee Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("Note"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Note",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("Date"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Date",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 6),
                   Text("Category"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Select Category",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("Tag"),
                  SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Select Tag",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
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
  
  onPressed: (){}, child: Text("Add Expense"),),
  SizedBox(height: 10),

                ],
              ),),
              
            ),

                      
      
            

        ],
        ),
        ),
      ),
    );
  }
}
