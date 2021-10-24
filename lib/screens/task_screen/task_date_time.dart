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
                  label: Text(
                    "${DateFormat.MMMEd().format(dateTime!.toLocal())}, ${DateFormat.jm().format(dateTime!.toLocal())}",
                  ),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 17,
                  ),
                  onDeleted: clear,
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            )
          : const Text('Add date/time'),
      onTap: () async {
        FocusScope.of(context).unfocus();
        var date = await showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        );
        if (date != null) {
          var time = await showTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 7, minute: 0),
          );
          if (time != null) {
            date = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            update(date.toUtc());
          }
        }
      },
    );
  }
}
