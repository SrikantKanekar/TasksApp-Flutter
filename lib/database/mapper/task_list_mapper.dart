import 'dart:convert';

import 'package:tasks/database/entity/task_list_entity.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/util/enums/order.dart';

class TaskListMapper {
  TaskList mapFromDatabase(TaskListEntity entity) {
    var decoded = json.decode(entity.tasks);
    var tasks = List<Task>.from(decoded.map((task)=> Task.fromJson(task)));
    return TaskList(
      id: entity.id!,
      name: entity.name,
      tasks: tasks,
      order: Order.values[entity.order],
    );
  }

  TaskListEntity mapToDatabase(TaskList taskList) {
    return TaskListEntity(
      id: taskList.id,
      name: taskList.name,
      tasks: json.encode(taskList.tasks),
      order: taskList.order.index,
    );
  }


}
