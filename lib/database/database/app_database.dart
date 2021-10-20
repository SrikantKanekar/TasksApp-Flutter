import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:tasks/database/dao/task_list_dao.dart';
import 'package:tasks/database/entity/task_list_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [TaskListEntity])
abstract class AppDatabase extends FloorDatabase {
  TaskListDao get taskListDao;
}