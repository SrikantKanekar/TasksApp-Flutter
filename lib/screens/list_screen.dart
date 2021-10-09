import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/list';
  final TextEditingController controller = TextEditingController();
  bool newList = true;

  ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments as String?;
    if (name != null) {
      controller.text = name;
      newList = false;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title:
            newList ? const Text('Create new list') : const Text('Rename list'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          )
        ],
      ),
      body: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (value) {
          Navigator.of(context).pop();
        },
        decoration: const InputDecoration(
          hintText: 'Enter list title',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}
