import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/repository.dart';

class TaskListsBloc {
  final _repository = Repository();

  // Controllers
  final _taskListsController = BehaviorSubject<List<TaskList>>();
  final _taskListController = StreamController<TaskList>();
  final _taskController = StreamController<Task>();

  // Streams
  Stream<List<TaskList>> get taskLists => _taskListsController.stream;

  // Sink
  Function(TaskList) get addTaskList => _taskListController.sink.add;
  Function(Task) get addTask => _taskController.sink.add;

  TaskListsBloc() {
    _taskListsController.sink.add(_repository.data);

    _taskListController.stream.listen((taskList) {
      var taskLists = _taskListsController.value;
      taskLists.add(taskList);
      _taskListsController.sink.add(taskLists);
    });

    _taskController.stream.listen((task) {
      // _taskListsController.sink.
    });
  }

  String? getListName(Task task) {
    for (var list in _taskListsController.value) {
      if (list.tasks.contains(task)) {
        return list.name;
      }
    }
  }


  dispose() {
    _taskListsController.close();
    _taskListController.close();
    _taskController.close();
  }
}
