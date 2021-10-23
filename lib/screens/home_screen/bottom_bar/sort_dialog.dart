import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/screens/loading_screen/loading_screen.dart';
import 'package:tasks/model/order.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key? key}) : super(key: key);

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    var bloc = TaskListsProvider.of(context);
    var index = bloc.getCurrentIndex();

    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if(!snapshot.hasData){
          return const LoadingScreen();
        }
        return AlertDialog(
          title: const Text('Sort by'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('Default'),
                value: Order.normal,
                groupValue: snapshot.data![index].order,
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
                groupValue: snapshot.data![index].order,
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
    );
  }
}
