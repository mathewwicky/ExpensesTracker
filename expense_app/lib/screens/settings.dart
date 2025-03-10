import 'package:flutter/material.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Management')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
          ElevatedButton(
            
            style: ElevatedButton.styleFrom(

              elevation: 2,
              minimumSize: Size(400, 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
                            Navigator.pushNamed(context, "/managecategory");

            },
            child: Text("Manage Category"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            
            style: ElevatedButton.styleFrom(

              elevation: 2,
              minimumSize: Size(400, 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/managetags");
            },
            child: Text("Manage Tag"),
          ),
        ],
      ),
    );
  }
}
