import 'package:flutter/material.dart';

class Addcategory extends StatefulWidget {
  const Addcategory({super.key});

  @override
  State<Addcategory> createState() => _AddcategoryState();
}

class _AddcategoryState extends State<Addcategory> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Category"),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: "Add Category"),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(onPressed: (){
          final categoryName = _nameController.text;
          if(categoryName.isNotEmpty){
            Navigator.of(context).pop(categoryName);
          }
        }, child: Text("Add"),),
      ],
    );
  }

  @override
void dispose(){
  _nameController.dispose();

  super.dispose();
}
}
