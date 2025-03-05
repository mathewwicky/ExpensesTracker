class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name
  });

  // convert the object to JSON using the toJson() method

Map<String, dynamic> toJson(){
  return{
    'id': id,
    'name': name
  };
}

// convert the JSON data back to Dart-Object we use a fromJson()

factory Category.fromJson(Map<String, dynamic> jsonData){
  return Category(id: jsonData['id'], name: jsonData['name']);
}

}