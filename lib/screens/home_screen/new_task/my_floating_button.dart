import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tasks/screens/home_screen/new_task/new_task_content.dart';

class MyFloatingButton extends StatefulWidget {

  const MyFloatingButton({Key? key}) : super(key: key);

  @override
  State<MyFloatingButton> createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  bool keyboardExpanded = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardExpanded = visible;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      child: const Icon(Icons.add),
      onPressed: () {
        showNewTaskBottomSheet();
      },
    );
  }

  showNewTaskBottomSheet(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState){
            return Padding(
                padding: EdgeInsets.only(
                  bottom: keyboardExpanded ? 265 : 16,
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: const NewTaskContent()
            );
          },
        );
      },
    );
  }
}
