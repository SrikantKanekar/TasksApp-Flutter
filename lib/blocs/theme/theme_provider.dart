import 'package:flutter/material.dart';
import 'package:tasks/blocs/theme/theme_bloc.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeBloc bloc;

  ThemeProvider({
    Key? key,
    required Widget child,
  })  : bloc = ThemeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ThemeBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ThemeProvider>()
            as ThemeProvider)
        .bloc;
  }
}
