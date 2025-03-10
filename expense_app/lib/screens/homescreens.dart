import 'package:flutter/material.dart';
import 'package:expense_app/screens/expensescreen.dart';
import 'settings.dart';

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
    //CategoryManagementScreen(),
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
}

class Homescreens extends StatelessWidget {
  const Homescreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/addexpense');
      } , child: Icon(Icons.add),),
    );
  }
}
