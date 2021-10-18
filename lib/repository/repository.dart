import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/fake_data.dart';

class Repository {
  late final List<TaskList> data;

  Repository(){
    data = fakeData;
  }
}
