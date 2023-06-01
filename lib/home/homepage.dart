// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:advocatus/home/drawer.dart';
import 'package:advocatus/home/homescreen.dart';
import 'package:advocatus/home/map.dart';
import 'package:advocatus/home/notification.dart';
import 'package:advocatus/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabcontroller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      HomeScreen(),
      MapScreen(),
      NotificationScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: Color(0xFFBD905A),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.map),
        activeColorPrimary: Color(0xFFBD905A),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        activeColorPrimary: Color(0xFFBD905A),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline_outlined),
        activeColorPrimary: Color(0xFFBD905A),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        context,
        screens: _buildScreen(),
        items: _navBarItem(),
        controller: _tabcontroller,
        backgroundColor: Color(0xFF242632),
        confineInSafeArea: true,
        // handleAndroidBackButtonPress: false,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(borderRadius: BorderRadius.circular(8)),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
