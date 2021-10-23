import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/blocs/theme/theme_provider.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var themeBloc = ThemeProvider.of(context);
    var bloc = TaskListsProvider.of(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            auth.getUser?.username ?? '',
            style: const TextStyle(fontSize: 22),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: CircleAvatar(
              backgroundColor: Color(0xFF3E3E3E),
              child: Icon(
                Icons.person,
                size: 40,
              ),
              radius: 30,
            ),
          ),
          Text(auth.getUser?.email ?? ''),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 0,
            thickness: 1,
          ),
          StreamBuilder(
            stream: themeBloc.theme,
            builder: (context, AsyncSnapshot<ThemeMode> snapshot) {
              return ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: const Text('Theme'),
                subtitle: Text(
                  snapshot.data == ThemeMode.dark ? 'dark' : 'light',
                ),
                trailing: Switch(
                  value: snapshot.data == ThemeMode.dark,
                  onChanged: (value) {
                    themeBloc.changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete account'),
            onTap: () {
              Navigator.of(context).pop();
              auth.deleteAccount();
              bloc.deleteDatabase();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              auth.logout();
              bloc.deleteDatabase();
            },
          )
        ],
      ),
    );
  }
}
