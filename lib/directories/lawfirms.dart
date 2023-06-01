// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advocatus/directories/lawfirm.dart';
import 'package:advocatus/home/drawer.dart';
import 'package:advocatus/home/homepage.dart';
import 'package:advocatus/home/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Lawfirms extends StatefulWidget {
  const Lawfirms({super.key});

  @override
  State<Lawfirms> createState() => _LawfirmsState();
}

class _LawfirmsState extends State<Lawfirms> {
  final Stream<QuerySnapshot> _lawfirmStream =
      FirebaseFirestore.instance.collection('lawfirms').snapshots();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/lawfirm': (context) => Lawfirm(),
        '/map': (context) => MapScreen(),
        // add the NextScreen route
      },
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Lawfirms',
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    //Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 47,
                              child: TextField(
                                cursorColor: Color(0xFFBD905A),
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFFBD905A),
                                  ),
                                  hintText: 'Search Lawfirms',
                                  hintStyle:
                                      TextStyle(fontStyle: FontStyle.italic),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Search bar goes here
                    //Column for the lawfirms profile

                    Divider(
                      color: Color(0xFF3827B40F),
                      thickness: 5,
                    ),
                    ///////////////////
                    StreamBuilder<QuerySnapshot>(
                        stream: _lawfirmStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Loading..');
                          }
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/lawfirm',
                                        arguments: data);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: 100,
                                                height: 105,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(data[
                                                            'image'] ??
                                                        'https://th.bing.com/th/id/OIP.od2CBW4Pu7yx6v7I9gb6SwHaHa?pid=ImgDet&rs=1'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.more_horiz,
                                                color: Color(0xFFBD905A),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 16, 0, 4),
                                                  child: Text(
                                                    data['name'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 1, 0, 2),
                                                  child: Text(
                                                    data['legal'],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 1, 0, 0),
                                                  child: Text(
                                                    data['location'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 90),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                  'assets/message.png',
                                                ),
                                              ),
                                              Expanded(
                                                child: Image.asset(
                                                  'assets/call.png',
                                                ),
                                              ),
                                              Expanded(
                                                child: Image.asset(
                                                  'assets/contact.png',
                                                ),
                                              ),
                                              Expanded(
                                                child: Image.asset(
                                                  'assets/lawfirm.png',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                    Divider(
                      color: Color(0xFF3827B40F),
                      thickness: 5,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
