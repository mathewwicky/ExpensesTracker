import 'package:flutter/material.dart';

class Addtag extends StatefulWidget {
  const Addtag({super.key});

  @override
  State<Addtag> createState() => _AddcategoryState();
}

class _AddcategoryState extends State<Addtag> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Tag"),
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
