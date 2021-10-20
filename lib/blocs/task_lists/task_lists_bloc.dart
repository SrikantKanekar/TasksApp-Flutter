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

  addTaskList(TaskList taskList) {
    repository.addTaskList(taskList);
  }

  renameTaskList(String name) {
    repository.renameTaskList(name, listIndex);
  }

  updateTaskListOrder(Order order) {
    repository.updateTaskListOrder(order, listIndex);
  }

  deleteTaskList() {
    repository.deleteTaskList(listIndex);
    listIndex = 0;
    _listIndexController.sink.add(0);
  }

  // Task
  Future<Task> getTaskById(String id) async {
    return repository.getTaskById(id, listIndex);
  }

  addTask(Task task) {
    repository.addTask(task, listIndex);
  }

  updateTask(Task task) {
    repository.updateTask(task, listIndex);
  }

  toggleCompleted(Task task) {
    repository.toggleCompleted(task, listIndex);
  }

  changeTaskList(Task task, String name) async {
    var newIndex = await repository.changeTaskList(task, name, listIndex);
    listIndex = newIndex;
    _listIndexController.sink.add(newIndex);
  }

  deleteTask(Task task) {
    repository.deleteTask(task, listIndex);
  }

  deleteCompletedTasks() {
    repository.deleteCompletedTasks(listIndex);
  }

  dispose() {
    _listIndexController.close();
  }
}
