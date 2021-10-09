import 'package:flutter/material.dart';
import 'package:tasks/screens/list_screen.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          title: const Text('Sort by'),
          subtitle: const Text('My Order'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text('Sort by'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                        title: Text('My order'),
                        value: true,
                        groupValue: true,
                        onChanged: null,
                      ),
                      RadioListTile(
                        title: Text('Date'),
                        value: true,
                        groupValue: true,
                        onChanged: null,
                      )
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                );
              },
            );
          },
        ),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          title: const Text('Rename list'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(
              ListScreen.routeName,
              arguments: 'old list name',
            );
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          title: const Text('Delete list'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          title: const Text('Delete all completed tasks'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text('Delete'),
                  content: const Text('Are you sure?'),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('OK'),
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
