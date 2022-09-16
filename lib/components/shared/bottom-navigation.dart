import 'package:flutter/material.dart';

class BottomNavigationElement extends StatelessWidget {
  final int index;
  const BottomNavigationElement({required Key key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      selectedItemColor: Colors.black,
      selectedFontSize: 13,
      unselectedItemColor: Colors.grey.shade500,
      unselectedFontSize: 10,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          label: "JOBS",
          icon: Icon(Icons.list_alt_outlined),
        ),
        BottomNavigationBarItem(
          label: "PROFILE",
          icon: Icon(Icons.person_outline),
        ),
        BottomNavigationBarItem(
          label: "SETTINGS",
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
