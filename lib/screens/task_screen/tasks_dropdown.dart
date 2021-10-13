import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists_provider.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';

class TasksDropdown extends StatelessWidget {
  final Task task;

  const TasksDropdown({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = TaskListsProvider.of(context);
    var listName = bloc.getListName(task);

    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16, top: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: listName!,
              items: snapshot.data!
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
        );
      }
    );
  }
}
