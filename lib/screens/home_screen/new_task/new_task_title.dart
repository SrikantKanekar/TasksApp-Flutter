import 'package:flutter/material.dart';

class NewTaskTitle extends StatelessWidget {
  final TextEditingController titleController;
  final FocusNode focusNode;

  const NewTaskTitle({
    Key? key,
    required this.titleController,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      focusNode: focusNode,
      autofocus: true,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        hintText: 'New Task',
        border: InputBorder.none,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
