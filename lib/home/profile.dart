// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advocatus/directories/lawyerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _joinedAt;
  String? _userImageUrl;
  int? _phoneNumber;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getdata();
  }

  void getdata() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    // print('user.emal ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _name = userDoc.get('name');
      _email = userDoc.get('email');
      _joinedAt = userDoc.get('joinedAt');
      _phoneNumber = userDoc.get('phone');
      _userImageUrl = userDoc.get('imageUrl');
    });

    print('name $_name');

    // potential Error
    //final Future<DocumentSnapshot<Map<String, dynamic>>> userDoc =
    //FirebaseFirestore.instance.collection('users').doc(_uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/log.png',
                height: 150,
                width: 150,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc()
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final userData = snapshot.data!.data();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    //Column for the layer profile picture
                    Column(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 1.0,
                              ),
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(_userImageUrl ??
                                  'https://th.bing.com/th/id/OIP.od2CBW4Pu7yx6v7I9gb6SwHaHa?pid=ImgDet&rs=1'),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text(
                                _name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                'Ndola, Zambia',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 90),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/message.png',
                              color: Color(0xFFBD905A),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/call.png',
                              color: Color(0xFFBD905A),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/contact.png',
                              color: Color(0xFFBD905A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.asset('assets/message.png'),
                            title: Text(_email!),
                          ),
                          ListTile(
                            leading: Image.asset('assets/call.png'),
                            title: Text(_phoneNumber.toString()),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xFF3827B40F),
                      thickness: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Interests',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBD905A),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Child Advoacte',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBD905A),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Self Defense',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBD905A),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'GBV',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     FirebaseAuth.instance.signOut();
                    //   },
                    //   child: ListTile(
                    //     title: Text(
                    //       'Logout',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 21,
                    //       ),
                    //     ),
                    //     leading: Icon(
                    //       Icons.logout,
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
