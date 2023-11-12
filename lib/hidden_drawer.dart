import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:todo_list/screen_AddTodo.dart';
import 'package:todo_list/screen_home.dart';
import 'package:todo_list/settings.dart';

import 'screen_dashboard.dart';

class HidddenDrawer extends StatefulWidget {
  const HidddenDrawer({super.key});

  @override
  State<HidddenDrawer> createState() => _HidddenDrawerState();
}

class _HidddenDrawerState extends State<HidddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final _selectedText = const TextStyle(
    color: Color.fromARGB(255, 44, 114, 52),
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  final _baseText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Home",
          baseStyle: _baseText,
          selectedStyle: _selectedText,
          colorLineSelected: Color.fromARGB(255, 54, 114, 44),
        ),
        const Dashboard(),
      ),
      /* ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Add Todo",
            baseStyle: _baseText,
            selectedStyle: _selectedText,
            colorLineSelected: const Color.fromARGB(255, 114, 44, 54),
          ),
          const AddTodo()), */
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Profile",
            baseStyle: _baseText,
            selectedStyle: _selectedText,
            colorLineSelected: const Color.fromARGB(255, 114, 44, 54),
          ),
          const SettingsPage())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Color.fromARGB(255, 133, 210, 133),
      initPositionSelected: 0,
      isTitleCentered: true,
      // enableShadowItensMenu: true,
      // disableAppBarDefault: true,
      // slidePercent: 40,
    );
  }
}
