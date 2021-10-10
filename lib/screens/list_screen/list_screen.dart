import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/list';

  ListScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments as String?;
    controller.text = name ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: name == null
            ? const Text('Create new list')
            : const Text('Rename list'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO(add or rename list)
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
          // TODO(add or rename list)
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
