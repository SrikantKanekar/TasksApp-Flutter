import 'package:flutter/material.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/repository/data.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task';

  TaskScreen({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as Task;
    var listName = getListName(task);
    titleController.text = task.name;
    descController.text = task.description;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO(delete current task)
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: listName!,
                items: tasksLists
                    .map(
                      (list) => DropdownMenuItem(
                        value: list.name,
                        child: Text(list.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
            ),
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              hintText: 'Enter title',
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 25),
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: TextField(
              controller: descController,
              decoration: const InputDecoration(
                  hintText: 'Add details', border: InputBorder.none),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('Add date/time'),
            onTap: () async {
              FocusScope.of(context).unfocus();
              var dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                    task.completed ? 'Mark uncompleted' : 'Mark completed'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getListName(Task task) {
    for (var list in tasksLists) {
      if (list.tasks.contains(task)) {
        return list.name;
      }
    }
  }
}
