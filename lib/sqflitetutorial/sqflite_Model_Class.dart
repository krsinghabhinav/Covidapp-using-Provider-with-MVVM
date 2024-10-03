class SqfliteModelClass {
  int? id;
  String name;
  int age;

  SqfliteModelClass({this.id, required this.name, required this.age});

// Map to model classs
  factory SqfliteModelClass.fromMap(Map<String, dynamic> map) {
    return SqfliteModelClass(id: map['id'], name: map['name'], age: map['age']);
  }

// model class to map
  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
