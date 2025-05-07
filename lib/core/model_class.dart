class Todo {
  String title;
  String description;

  bool isDone;
  bool isDeleted;

  Todo({
    required this.title,
    required this.isDone,
    required this.description,
    required this.isDeleted,
  });

  // toJson & serialization => convert to json format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  // fromJson

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      isDeleted: json['isDeleted'],
    );
  }
}
