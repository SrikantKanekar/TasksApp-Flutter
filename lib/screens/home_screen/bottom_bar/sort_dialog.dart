import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/util/enums/order.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key? key}) : super(key: key);

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    var bloc = TaskListsProvider.of(context);
    var order = bloc.getCurrentTaskListOrder();

    return AlertDialog(
      title: const Text('Sort by'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('Normal'),
            value: Order.normal,
            groupValue: order,
            onChanged: (Order? value) {
              setState(() {
                bloc.updateTaskListOrder(value!);
              });
              Navigator.of(context).pop();
            },
          ),
          RadioListTile(
            title: const Text('Date'),
            value: Order.date,
            groupValue: order,
            onChanged: (Order? value) {
              setState(() {
                bloc.updateTaskListOrder(value!);
              });
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
