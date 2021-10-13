import 'package:flutter/material.dart';

class TaskDateTime extends StatelessWidget {
  const TaskDateTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_today_rounded),
      title: const Text('Add date/time'),
      onTap: () async {
        FocusScope.of(context).unfocus();
        var dateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        );
      },
    );
  }
}
