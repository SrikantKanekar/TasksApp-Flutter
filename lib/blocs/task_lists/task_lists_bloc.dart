import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/repository.dart';
import 'package:tasks/util/enums/order.dart';

class TaskListsBloc {
  final _taskLists = Repository().data;
  int _listIndex = 0;

  // Controllers
  final _taskListsController = BehaviorSubject<List<TaskList>>();
  final _listIndexController = BehaviorSubject<int>();

  // Streams
  Stream<List<TaskList>> get taskLists => _taskListsController.stream;
  Stream<int> get listIndex => _listIndexController.stream;

  // Sink
  Function(int) get changeListIndex => _listIndexController.sink.add;

  TaskListsBloc() {
    _taskListsController.sink.add(_taskLists);
    _listIndexController.sink.add(_listIndex);

    _listIndexController.stream.listen((index) => _listIndex = index);
  }

  // TaskList
  String? getCurrentTaskListName() => _taskLists[_listIndex].name;
  Order getCurrentTaskListOrder() => _taskLists[_listIndex].order;

  addTaskList(TaskList taskList) {
    _taskLists.add(taskList);
    _taskListsController.sink.add(_taskLists);
  }

  renameTaskList(String name) {
    _taskLists[_listIndex].name = name;
    _taskListsController.sink.add(_taskLists);
  }

  updateTaskListOrder(Order order) {
    _taskLists[_listIndex].order = order;
    _taskListsController.sink.add(_taskLists);
  }

  deleteTaskList() {
    _taskLists.removeAt(_listIndex);
    _listIndex = 0;
    _listIndexController.sink.add(0);
    _taskListsController.sink.add(_taskLists);
  }

  // Task
  Task getTaskById(String id) => _taskLists[_listIndex].tasks.firstWhere((task) => task.id == id);

  addTask(Task task) {
    _taskLists[_listIndex].tasks.add(task);
    _taskListsController.sink.add(_taskLists);
  }

  updateTask(Task task) {
    var taskIndex = _taskLists[_listIndex].tasks.indexWhere((item) => item.id == task.id);
    _taskLists[_listIndex].tasks[taskIndex] = task;
    _taskListsController.sink.add(_taskLists);
  }

  toggleCompleted(Task task) {
    var taskIndex = _taskLists[_listIndex].tasks.indexWhere((item) => item.id == task.id);
    _taskLists[_listIndex].tasks[taskIndex].completed = !task.completed;
    _taskListsController.sink.add(_taskLists);
  }

  changeTaskList(Task task, String name) {
    _taskLists[_listIndex].tasks.removeWhere((item) => item.id == task.id);

    var newListIndex = _taskLists.indexWhere((list) => list.name == name);
    _listIndex = newListIndex;
    _listIndexController.sink.add(newListIndex);

    _taskLists[_listIndex].tasks.add(task);
    _taskListsController.sink.add(_taskLists);
  }

  deleteTask(Task task) {
    _taskLists[_listIndex].tasks.removeWhere((item) => item.id == task.id);
    _taskListsController.sink.add(_taskLists);
  }

  deleteCompletedTasks() {
    _taskLists[_listIndex].tasks.removeWhere((task) => task.completed);
    _taskListsController.sink.add(_taskLists);
  }

  dispose() {
    _taskListsController.close();
    _listIndexController.close();
  }
}
