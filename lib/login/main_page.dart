// ignore_for_file: prefer_const_constructors

import 'package:advocatus/home/homepage.dart';
import 'package:advocatus/login/auth_page.dart';
import 'package:advocatus/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          context,
          userSnapshot,
        ) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              return HomePage();
            } else {
              return AuthPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text('Error Occured'),
            );
          }
          return Container();
        });
  }
}
