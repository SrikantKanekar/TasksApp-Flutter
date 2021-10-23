import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/model/task.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/model/task_list.dart';
import 'package:tasks/network/network_data_source.dart';
import 'package:tasks/model/order.dart';

class NetworkDataSourceImpl extends NetworkDataSource {

  @override
  Future<List<TaskList>> getTaskLists() async {
    var url = Uri.parse('http://10.0.2.2:3000/task-lists');
    var response = await http.get(url, headers: await authHeaders());
    var decoded = json.decode(response.body);
    var taskLists = List<TaskList>.from(
        decoded.map((taskList) => TaskList.fromJson(taskList)),
    );
    if (response.statusCode == 200) return taskLists;
    throw Exception(response.body);
  }

  @override
  Future<void> addTaskList(TaskList taskList) async {
    var url = Uri.parse('http://10.0.2.2:3000/task-lists');
    var body = json.encode(taskList);
    var response = await http.post(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 201) return;
    throw Exception(response.body);
  }

  @override
  Future<void> renameTaskList(String name, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/task-lists/name/$index');
    var response = await http.put(url, body: name, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> updateTaskListOrder(Order order, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/task-lists/order/$index');
    var value = order == Order.date ? 'Date' : 'Normal';
    var response = await http.put(url, body: value, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> deleteTaskList(int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/task-lists/$index');
    var response = await http.delete(url, headers: await authHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  void addTask(Task task, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/$index');
    var body = jsonEncode(task);
    var response = await http.post(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 201) return;
    throw Exception(response.body);
  }

  @override
  Future<void> updateTask(Task task, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/$index');
    var body = jsonEncode(task);
    var response = await http.put(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> toggleCompleted(Task task, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/toggle/$index');
    var body = jsonEncode(task);
    var response = await http.put(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> changeTaskList(Task task, String name, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/change/$index/$name');
    var body = jsonEncode(task);
    var response = await http.put(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> deleteTask(Task task, int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/$index/task');
    var body = jsonEncode(task);
    var response = await http.delete(url, body: body, headers: await postAuthHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  @override
  Future<void> deleteCompletedTasks(int index) async {
    var url = Uri.parse('http://10.0.2.2:3000/tasks/$index/completed');
    var response = await http.delete(url, headers: await authHeaders());
    if (response.statusCode == 200) return;
    throw Exception(response.body);
  }

  Future<Map<String, String>> authHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> postAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    return {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    };
  }
}
