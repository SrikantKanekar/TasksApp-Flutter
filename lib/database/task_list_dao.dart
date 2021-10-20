import 'package:floor/floor.dart';
import 'package:tasks/database/task_list_entity.dart';

@dao
abstract class TaskListDao {

  @Query('SELECT * FROM TaskListEntity')
  Future<List<TaskListEntity>> getAllTaskLists();

  @Query('SELECT * FROM TaskListEntity')
  Stream<List<TaskListEntity>> getAllTaskListsAsStream();

  @insert
  Future<void> insertList(TaskListEntity taskList);

  @update
  Future<void> updateList(TaskListEntity taskList);

  @delete
  Future<void> deleteList(TaskListEntity taskList);
}