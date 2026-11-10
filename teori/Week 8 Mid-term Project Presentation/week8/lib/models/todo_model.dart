class TodoModel {
  final int id;
  final String name;
  final String description;
  final bool isDone;

  TodoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isDone: json['is_done'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'is_done': isDone,
    };
  }
}