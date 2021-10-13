import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/list';

  ListScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bloc = TaskListsProvider.of(context);
    var name = ModalRoute.of(context)!.settings.arguments as String?;
    controller.text = name ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: name == null
            ? const Text('Create new list')
            : const Text('Rename list'),
        actions: [
          TextButton(
            onPressed: () {
              bloc.addTaskList(
                TaskList(name: controller.text, tasks: []),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          )
        ],
      ),
      body: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (value) {
          bloc.addTaskList(
            TaskList(name: controller.text, tasks: []),
          );
          Navigator.of(context).pop();
        },
        decoration: const InputDecoration(
          hintText: 'Enter list title',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}
