import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Tasks',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: auth.isAuth
              ? const Scaffold()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : const AuthScreen(),
          ),
        ),
      ),
    );
  }
}
