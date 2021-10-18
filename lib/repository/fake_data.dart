import 'dart:math';

import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';

List<TaskList> fakeData = [
  TaskList(
    name: 'My Tasks',
    tasks: [
      Task(
        id: generateId(),
        name: 'Buy groceries',
      ),
      Task(
        id: generateId(),
        name: 'Return library books',
        dateTime: generateDate(3),
      ),
      Task(
        id: generateId(),
        name: 'Prepare food',
        completed: true,
      ),
      Task(
        id: generateId(),
        name: 'Do the laundry',
        completed: true,
      ),
      Task(
        id: generateId(),
        name: 'Visit doctor',
      ),
      Task(
        id: generateId(),
        name: 'Attend gym',
      ),
      Task(
        id: generateId(),
        name: 'Call mom',
        completed: true,
      ),
      Task(
        id: generateId(),
        name: 'Wash dishes',
      ),
      Task(
        id: generateId(),
        name: 'Repair my bike',
      ),
      Task(
        id: generateId(),
        name: 'Call Elon Musk',
        dateTime: generateDate(-2),
      ),
    ],
  ),
  TaskList(
    name: 'Flutter',
    tasks: [
      Task(
        id: generateId(),
        name: 'Add dependencies',
        completed: true,
      ),
      Task(
        id: generateId(),
        name: 'Design UI',
        completed: true,
      ),
      Task(
        id: generateId(),
        name: 'Implement UI',
      ),
      Task(
        id: generateId(),
        name: 'Add database',
      ),
      Task(
          id: generateId(),
          name: 'Add Firebase',
      ),
      Task(
        id: generateId(),
        name: 'Complete project',
        dateTime: generateDate(3),
      ),
      Task(
        id: generateId(),
        name: 'Add snackbar',
      ),
    ],
  ),
  TaskList(
    name: 'Android',
    tasks: [
      Task(
        id: generateId(),
        name: 'Complete project',
        dateTime: generateDate(3),
      ),
      Task(
        id: generateId(),
        name: 'Fix the bug',
      ),
      Task(
        id: generateId(),
        name: 'Update IDE',
        completed: true,
      ),
    ],
  ),
  TaskList(
    name: 'Movies',
    tasks: [
      Task(
        id: generateId(),
        name: 'Inception',
      ),
      Task(
        id: generateId(),
        name: 'Interstellar',
      ),
      Task(
        id: generateId(),
        name: 'WALL-E',
      ),
      Task(
        id: generateId(),
        name: 'Avengers',
      ),
      Task(
        id: generateId(),
        name: 'Toy story',
      ),
      Task(
        id: generateId(),
        name: 'Titanic',
      ),
    ],
  ),
];

String generateId() {
  return Random().nextInt(10000).toString();
}

DateTime generateDate(int value) {
  return DateTime.now().add(Duration(days: value));
}
