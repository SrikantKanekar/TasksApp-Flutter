import 'package:flutter/material.dart';
import 'package:tasks/screens/home_screen/bottom_bar/menu_botton_sheet.dart';
import 'package:tasks/screens/home_screen/bottom_bar/options_botton_sheet.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: 'menu',
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return const MenuBottomSheet();
                },
              );
            },
          ),
          IconButton(
            tooltip: 'options',
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return const OptionsBottomSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
