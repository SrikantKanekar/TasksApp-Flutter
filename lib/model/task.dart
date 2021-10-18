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
