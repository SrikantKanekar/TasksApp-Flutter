import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/screens/list_screen/list_screen.dart';

class MenuBottomSheet extends StatelessWidget {
  final Function(int) changeTab;

  const MenuBottomSheet({
    Key? key,
    required this.changeTab,
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Column(
                children: snapshot.data!
                    .map(
                      (list) => ListTile(
                        contentPadding: const EdgeInsets.only(left: 82),
                        title: Text(list.name),
                        onTap: () {
                          Navigator.of(context).pop();
                          var index = snapshot.data!.indexOf(list);
                          changeTab(index);
                        },
                      ),
                    )
                    .toList(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Create new list'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    ListScreen.routeName,
                  );
                },
              ),
              const SizedBox(height: 8)
            ],
          );
        });
  }
}
