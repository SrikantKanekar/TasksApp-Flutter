import 'package:auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/screens/home_screen/home_screen.dart';
import 'package:tasks/screens/list_screen/list_screen.dart';
import 'package:tasks/screens/task_screen/task_screen.dart';

import 'blocs/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: ThemeProvider(
        child: TaskListsProvider(
          child: const App()
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeProvider.of(context);
    return StreamBuilder(
      stream: themeBloc.theme,
      builder: (context, AsyncSnapshot<ThemeMode> snapshot) {
        return Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Tasks',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: snapshot.data,
            debugShowCheckedModeBanner: false,
            home: auth.isAuth
                ? const HomeScreen()
                : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? const SplashScreen()
                  : const AuthScreen(),
            ),
            routes: {
              ListScreen.routeName: (ctx) => ListScreen(),
              TaskScreen.routeName: (ctx) => const TaskScreen()
            },
          ),
        );
      },
    );
  }
}
