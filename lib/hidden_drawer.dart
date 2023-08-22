import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:todo_list/screen_AddTodo.dart';
import 'package:todo_list/screen_home.dart';
import 'package:todo_list/settings.dart';

class HidddenDrawer extends StatefulWidget {
  const HidddenDrawer({super.key});

  @override
  State<HidddenDrawer> createState() => _HidddenDrawerState();
}

class _HidddenDrawerState extends State<HidddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final _selectedText = const TextStyle(
    color: Color.fromARGB(255, 114, 44, 54),
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
          colorLineSelected: const Color.fromARGB(255, 114, 44, 54),
        ),
        const HomeScreen(),
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Add Todo",
            baseStyle: _baseText,
            selectedStyle: _selectedText,
            colorLineSelected: const Color.fromARGB(255, 114, 44, 54),
          ),
          const AddTodo()),
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
      backgroundColorMenu: const Color(0xFFD28594),
      initPositionSelected: 0,
      isTitleCentered: true,
      // enableShadowItensMenu: true,
      // disableAppBarDefault: true,
      // slidePercent: 40,
    );
  }
}
