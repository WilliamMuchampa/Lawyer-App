// ignore_for_file: prefer_const_constructors

// import 'package:advocatus/suli/auth.dart';
import 'package:advocatus/home/homepage.dart';
import 'package:advocatus/home/homescreen.dart';
import 'package:advocatus/home/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // Future signOut() async {
  //   await Auth().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF242632),
      child: Padding(
        padding: EdgeInsets.only(left: 40, top: 120),
        child: Column(
          children: <Widget>[
            //body

            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
                leading: Icon(Icons.home, color: Colors.white),
              ),
            ),

            InkWell(
              onTap: () => PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: NotificationScreen(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              ),
              child: ListTile(
                title: Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
                leading: Icon(Icons.notifications, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Location',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
                leading: Icon(Icons.map, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Courses',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
                leading: Icon(Icons.school_sharp, color: Colors.white),
              ),
            ),

            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
