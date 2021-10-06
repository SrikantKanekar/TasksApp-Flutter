import 'package:flutter/material.dart';
import 'package:tasks/screens/task_screen.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, TaskScreen.routeName);
      },
    );
  }
}
