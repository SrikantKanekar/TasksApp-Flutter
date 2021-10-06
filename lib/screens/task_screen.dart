import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Task Screen'),
      ),
    );
  }
}
