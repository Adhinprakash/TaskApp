class Task {
  String id;
  String title;
  String description;
  bool isCompleted;

  Task({required this.id, required this.title, required this.description, required this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}