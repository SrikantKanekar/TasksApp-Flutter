import 'package:flutter/material.dart';

class TaskDescription extends StatelessWidget {
  final TextEditingController descController;

  const TaskDescription({
    Key? key,
    required this.descController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notes),
      title: TextField(
        controller: descController,
        decoration: const InputDecoration(
          hintText: 'Add details',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
