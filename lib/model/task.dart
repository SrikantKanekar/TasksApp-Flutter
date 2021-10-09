class Task {
  final String id;
  final String name;
  final String description;
  final DateTime? dateTime;
  final bool completed;

  Task({
    required this.id,
    required this.name,
    required this.description,
    this.dateTime,
    required this.completed,
  });
}
