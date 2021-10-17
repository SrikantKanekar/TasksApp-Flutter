import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDateTime extends StatelessWidget {
  final DateTime? dateTime;
  final Function(DateTime) update;
  final VoidCallback clear;

  const TaskDateTime({
    Key? key,
    required this.dateTime,
    required this.update,
    required this.clear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_today_rounded),
      title: dateTime != null
          ? Stack(
              children: [
                Chip(
                  padding: const EdgeInsets.all(10),
                  label: Text(DateFormat.MMMEd().format(dateTime!)),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 17,
                  ),
                  onDeleted: clear,
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ],
            )
          : const Text('Add date/time'),
      onTap: () async {
        FocusScope.of(context).unfocus();
        var value = await showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        );
        if (value != null) {
          update(value);
        }
      },
    );
  }
}
