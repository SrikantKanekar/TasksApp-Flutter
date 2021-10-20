class Task extends Comparable<Task> {
  final String id;
  final String name;
  final String description;
  DateTime? dateTime;
  bool completed;

  Task({
    required this.id,
    required this.name,
    this.description = '',
    this.dateTime,
    this.completed = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        dateTime = DateTime.tryParse(json['dateTime'] ?? ''),
        completed = json['completed'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'description' : description,
    'dateTime' : dateTime?.toIso8601String(),
    'completed' : completed
  };

  @override
  int compareTo(Task other) {
    if(dateTime == null && other.dateTime == null){
      return 0;
    }
    if(other.dateTime == null){
      return 1;
    }
    if(dateTime == null){
      return -1;
    }
    return other.dateTime!.compareTo(dateTime!);
  }
}
