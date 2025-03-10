import 'package:expense_app/screens/expensescreen.dart';
import 'package:expense_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/models/expense.dart';



class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectIndex = 0;
  final List<Widget> _screens = [
    Homescreens(),
    Expensescreen(),
    Settingscreen(),
  ];

  void _onItemTaped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(title: Text("Welcome"),),
      body: _screens[_selectIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: _onItemTaped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Expenses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
  // debug to show the Json data
//   @override
// void initState() {
//   super.initState();
//   Future.delayed(Duration.zero, () {
//     Provider.of<ExpenseProvider>(context, listen: false)
//         .debugPrintStoredExpenses();
//   });
// }

}

class Homescreens extends StatelessWidget {
  const Homescreens({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // drawer: Drawer(
        //   child: ListView(children: [Text("Manage Category"),
        //   Text("Manage Tags")],),
        // ),
        appBar: AppBar(
          title: Text(
            "Expense App",
            style: TextStyle(fontFamily: "Trajan Pro", fontSize: 28),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'By Date'),
              Tab(text: 'By Category'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GroupedExpenseList(groupBy: GroupBy.date),
            GroupedExpenseList(groupBy: GroupBy.category),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addexpense');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


enum GroupBy { date, category }

class GroupedExpenseList extends StatelessWidget {
  final GroupBy groupBy;

  const GroupedExpenseList({super.key, required this.groupBy});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    if (expenses.isEmpty) {
      return Center(child: Text("No expenses added yet."));
    }

    // Group expenses
    final Map<String, List<Expense>> groupedExpenses = {};
    for (var expense in expenses) {
      String key = groupBy == GroupBy.date
          ? expense.date.toString().split(" ")[0] // Date only
          : expense.categoryId;

      if (!groupedExpenses.containsKey(key)) {
        groupedExpenses[key] = [];
      }
      groupedExpenses[key]!.add(expense);
    }

    final sortedKeys = groupedExpenses.keys.toList()
      ..sort((a, b) => groupBy == GroupBy.date
          ? b.compareTo(a) // descending dates
          : a.compareTo(b)); // alphabetical categories

    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final key = sortedKeys[index];
        final expensesForKey = groupedExpenses[key]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...expensesForKey.map((expense) => ListTile(
                  title: Text("${expense.payee} - \$${expense.amount}"),
                  subtitle: Text(expense.note),
                  trailing: Text(expense.tag),
                )),
          ],
        );
      },
    );
  }
}
