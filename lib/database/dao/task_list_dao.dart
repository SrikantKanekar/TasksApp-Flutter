import 'package:floor/floor.dart';
import 'package:tasks/database/entity/task_list_entity.dart';

@dao
abstract class TaskListDao {

  @Query('SELECT * FROM TaskListEntity')
  Future<List<TaskListEntity>> getAllTaskLists();

  @Query('SELECT * FROM TaskListEntity')
  Stream<List<TaskListEntity>> getAllTaskListsAsStream();

  @insert
  Future<void> insertList(TaskListEntity taskList);

  @insert
  Future<void> insertAll(List<TaskListEntity> taskLists);

  @Query('SELECT * FROM TaskListEntity WHERE name = :name')
  Future<TaskListEntity?> getListByName(String name);

  @update
  Future<void> updateList(TaskListEntity taskList);

  @update
  Future<void> updateAll(List<TaskListEntity> taskLists);

  @delete
  Future<void> deleteList(TaskListEntity taskList);

  @delete
  Future<void> deleteAll(List<TaskListEntity> taskLists);
}