import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/blocs/task_lists/task_lists_bloc.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/screens/home_screen/new_task/new_task_description.dart';
import 'package:tasks/screens/home_screen/new_task/new_task_title.dart';

class NewTaskContent extends StatefulWidget {
  const NewTaskContent({Key? key}) : super(key: key);

  @override
  _NewTaskContentState createState() => _NewTaskContentState();
}

class _NewTaskContentState extends State<NewTaskContent> {
  final FocusNode focusNode = FocusNode();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? dateTime;

  bool descExpanded = false;

  @override
  Widget build(BuildContext context) {
    var bloc = TaskListsProvider.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NewTaskTitle(
          titleController: _titleController,
          focusNode: focusNode,
        ),
        descExpanded
            ? NewTaskDescription(descController: _descController)
            : const SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      descExpanded = !descExpanded;
                    });
                  },
                  icon: const Icon(Icons.notes),
                ),
                dateTime != null
                    ? Chip(
                        padding: const EdgeInsets.all(10),
                        label: Text(
                          "${DateFormat.MMMEd().format(dateTime!)}, ${DateFormat.jm().format(dateTime!)}",
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 17,
                        ),
                        onDeleted: () {
                          setState(() {
                            dateTime = null;
                          });
                        },
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                          );
                          if (dateTime != null) {
                            var time = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 7, minute: 0),
                            );
                            if (time != null) {
                              dateTime = DateTime(
                                dateTime!.year,
                                dateTime!.month,
                                dateTime!.day,
                                time.hour,
                                time.minute,
                              );
                            } else {
                              dateTime = null;
                            }
                          }
                          setState(() {});
                          focusNode.requestFocus();
                        },
                        icon: const Icon(Icons.calendar_today_rounded),
                      ),
              ],
            ),
            TextButton(
              onPressed: () => submit(bloc),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ],
    );
  }

  submit(TaskListsBloc bloc) {
    var newTask = Task(
      id: Random().nextInt(10000).toString(),
      name: _titleController.text,
      description: _descController.text,
      dateTime: dateTime?.toUtc(),
      completed: false,
    );
    bloc.addTask(newTask);
    Navigator.of(context).pop();
  }
}
