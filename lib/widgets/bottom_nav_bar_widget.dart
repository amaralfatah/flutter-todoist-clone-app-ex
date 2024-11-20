import 'package:flutter/material.dart';

import '../constants.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPallete.blackLight,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: ColorPallete.white,
          ),
          label: 'Today',
          activeIcon: Icon(
            Icons.calendar_today,
            color: ColorPallete.red,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.inbox,
            color: ColorPallete.white,
          ),
          label: 'Today',
          activeIcon: Icon(
            Icons.inbox,
            color: ColorPallete.red,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: ColorPallete.white,
          ),
          label: 'Search',
          activeIcon: Icon(
            Icons.search,
            color: ColorPallete.red,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.article,
            color: ColorPallete.white,
          ),
          label: 'Browse',
          activeIcon: Icon(
            Icons.article,
            color: ColorPallete.red,
          ),
        ),
      ],
      selectedItemColor: ColorPallete.red,
      unselectedItemColor: ColorPallete.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
