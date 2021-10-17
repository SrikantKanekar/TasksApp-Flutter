import 'package:flutter/material.dart';

class NewTaskDescription extends StatelessWidget {
  final TextEditingController descController;

  const NewTaskDescription({
    Key? key,
    required this.descController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: descController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        hintText: 'Add details',
        border: InputBorder.none,
      ),
      style: const TextStyle(fontSize: 15),
    );
  }
}