class Tag {
  final String id;
  final String name;

  Tag({
    required this.id,
    required this.name
  });

  //convert the object to JSON data using the toJson()

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name
    };
  }

  //convert the JsonData to the Dart-Object using the fromJson()
  factory Tag.fromJson(Map<String, dynamic> jsonData){
    return Tag(id: jsonData['id'], name: jsonData['name']);
  }
}
