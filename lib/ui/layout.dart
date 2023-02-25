import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './homepage/index.dart';
import './job-post/new/index.dart';
import './profile/index.dart';
import './settings/index.dart';
import './theme_data/fonts.dart';
import '../data/auth.dart';
import '../ui/authentication/login.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({required Key key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  late int _currentIndex = 0;
  final List _screens = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _changeIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Image(
                  width: 85.0,
                  image: AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(width: 10.0),
                Container(
                  width: 1.0,
                  height: 20.0,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "PARTNER",
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.partnerHeading,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              onPressed: () {
                userProvider.logout();
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                    size: 15.0,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    'Logout',
                    style: GoogleFonts.dmSans(
                      fontSize: 12.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _screens[_currentIndex],
      bottomSheet: (_currentIndex == 0)
          ? Container(
              width: width,
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NewJobPost(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.add,
                              color: Colors.black, size: 15.0),
                          const SizedBox(width: 5.0),
                          Text(
                            "POST A NEW JOB",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.btnBlackText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(width: 0.0, height: 0.0),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _changeIndex,
        selectedItemColor: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
