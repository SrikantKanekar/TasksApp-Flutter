import 'package:tasks/database/entity_mapper.dart';
import 'package:tasks/database/task_list_dao.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/database/app_database.dart';
import 'package:tasks/util/enums/order.dart';

class Repository {
  late final TaskListDao dao;

  Repository() {
    init();
  }

  init() async {
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.taskListDao;
  }

  Stream<List<TaskList>> getTaskListsAsStream() {
    var data = dao.getAllTaskListsAsStream();
    return data.map(
      (list) => list
          .map((taskList) => EntityMapper().mapFromDatabase(taskList))
          .toList(),
    );
  }

  Future<List<TaskList>> getTaskLists() async {
    var data = await dao.getAllTaskLists();
    return data.map((list) => EntityMapper().mapFromDatabase(list)).toList();
  }

  void addTaskList(TaskList taskList) {
    dao.insertList(EntityMapper().mapToDatabase(taskList));
  }

  renameTaskList(String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.name = name;
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  updateTaskListOrder(Order order, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.order = order;
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  deleteTaskList(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    dao.deleteList(EntityMapper().mapToDatabase(list));
  }

  // Task
  Future<Task> getTaskById(String id, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    return list.tasks.firstWhere((task) => task.id == id);
  }

  addTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.add(task);
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  updateTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex] = task;
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  toggleCompleted(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex].completed = !task.completed;
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  Future<int> changeTaskList(Task task, String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);

    var newListIndex = taskLists.indexWhere((list) => list.name == name);
    var newList = taskLists[newListIndex];
    newList.tasks.add(task);

    dao.updateList(EntityMapper().mapToDatabase(list));
    dao.updateList(EntityMapper().mapToDatabase(newList));
    return newListIndex;
  }

  deleteTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);
    dao.updateList(EntityMapper().mapToDatabase(list));
  }

  deleteCompletedTasks(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((task) => task.completed);
    dao.updateList(EntityMapper().mapToDatabase(list));
  }
}
