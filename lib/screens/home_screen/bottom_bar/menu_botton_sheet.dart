import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/screens/list_screen/list_screen.dart';
import 'package:tasks/screens/loading_screen/loading_screen.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = TaskListsProvider.of(context);

    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingScreen();
        }
        return ListView(
          shrinkWrap: true,
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
                        bloc.changeListIndex(index);
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
      },
    );
  }
}
