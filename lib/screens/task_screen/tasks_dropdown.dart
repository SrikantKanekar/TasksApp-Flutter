import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';

class TasksDropdown extends StatelessWidget {
  final Function(String?) onChanged;

  const TasksDropdown({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = TaskListsProvider.of(context);

    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16, top: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: snapshot.data![bloc.getCurrentIndex()].name,
              items: snapshot.data!
                  .map(
                    (list) => DropdownMenuItem(
                      value: list.name,
                      child: Text(list.name),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}
