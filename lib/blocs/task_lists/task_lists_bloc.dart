import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/repository.dart';
import 'package:tasks/util/enums/order.dart';

class TaskListsBloc {
  final repository = Repository();
  int listIndex = 0;

  // Controllers
  final _listIndexController = BehaviorSubject<int>();

  // Streams
  Stream<List<TaskList>> get taskLists => repository.getTaskListsAsStream();
  Stream<int> get listIndexStream => _listIndexController.stream;

  // Sink
  Function(int) get changeListIndex => _listIndexController.sink.add;

  TaskListsBloc() {
    _listIndexController.sink.add(listIndex);
    _listIndexController.stream.listen((index) => listIndex = index);
  }

  // TaskList
  int getCurrentIndex() => listIndex;

  void addTaskList(TaskList taskList) {
    repository.addTaskList(taskList);
  }

  void renameTaskList(String name) {
    repository.renameTaskList(name, listIndex);
  }

  void updateTaskListOrder(Order order) {
    repository.updateTaskListOrder(order, listIndex);
  }

  void deleteTaskList() {
    repository.deleteTaskList(listIndex);
    listIndex = 0;
    _listIndexController.sink.add(0);
  }

  // Task
  Future<Task> getTaskById(String id) async {
    return repository.getTaskById(id, listIndex);
  }

  void addTask(Task task) {
    repository.addTask(task, listIndex);
  }

  void updateTask(Task task) {
    repository.updateTask(task, listIndex);
  }

  void toggleCompleted(Task task) {
    repository.toggleCompleted(task, listIndex);
  }

  void changeTaskList(Task task, String name) async {
    var newIndex = await repository.changeTaskList(task, name, listIndex);
    listIndex = newIndex;
    _listIndexController.sink.add(newIndex);
  }

  void deleteTask(Task task) {
    repository.deleteTask(task, listIndex);
  }

  void deleteCompletedTasks() {
    repository.deleteCompletedTasks(listIndex);
  }

  dispose() {
    _listIndexController.close();
  }
}
