import 'package:flutter/material.dart';
import 'package:tasks/repository/data.dart';
import 'package:tasks/screens/list_screen/list_screen.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Column(
          children: tasksLists
              .map(
                (list) => ListTile(
                  contentPadding: const EdgeInsets.only(left: 82),
                  title: Text(list.name),
                ),
              )
              .toList(),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Create new list'),
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(
              ListScreen.routeName,
            );
          },
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
