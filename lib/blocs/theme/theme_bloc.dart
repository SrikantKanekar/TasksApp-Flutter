import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc {

  // Controllers
  final _themeController = BehaviorSubject<ThemeMode>();

  // Streams
  Stream<ThemeMode> get theme => _themeController.stream;

  // Sink
  Function(ThemeMode) get changeTheme => _themeController.sink.add;

  ThemeBloc() {
    _themeController.sink.add(ThemeMode.dark);
  }

  dispose() {
    _themeController.close();
  }
}
