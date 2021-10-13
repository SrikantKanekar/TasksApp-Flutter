import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  final TextEditingController titleController;

  const TaskTitle({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        hintText: 'Enter title',
        border: InputBorder.none,
      ),
      style: const TextStyle(fontSize: 25),
    );
  }
}
