import 'package:flutter/material.dart';
import 'package:tasks/repository/data.dart';

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
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          title: const Text('Create new list'),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
