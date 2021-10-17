import 'package:flutter/material.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Username',
            style: TextStyle(fontSize: 22),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 30,
            ),
          ),
          const Text('useremail@abc.com'),
          const SizedBox(height: 10,),
          const Divider(height: 0, thickness: 1,),
          ListTile(
            leading: const Icon(Icons.color_lens_outlined),
            title: const Text('Theme'),
            subtitle: const Text('dark'),
            trailing: Switch(value: true, onChanged: (value) {}),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.supervisor_account),
            title: const Text('Add another account'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: (){},
          )
        ],
      ),
    );
  }
}
