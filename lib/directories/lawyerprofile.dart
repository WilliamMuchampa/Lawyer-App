// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advocatus/home/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LawyerProfile extends StatefulWidget {
  // final lawyername;
  // final lawyerlocation;
  // final lawyerspeciality;
  // final lawyerimage;
  LawyerProfile({
    Key? key,
    // this.lawyername,
    // this.lawyerlocation,
    // this.lawyerspeciality,
    // this.lawyerimage,
    // required Map<String, dynamic> arguments,
  }) : super(key: key);

  @override
  State<LawyerProfile> createState() => _LawyerProfileState();
}

class _LawyerProfileState extends State<LawyerProfile> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String fullName = data['name'];
    String email = data['email'];
    String location = data['location'];
    String lawyerimage = data['image'];
    String phone = data['phone'];
    return Scaffold(
        backgroundColor: Colors.white,
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
          // title: Text(
          //   'Lawyer',
          //   style: TextStyle(color: Colors.black),
          // ),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  //Column for the layer profile picture
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 105,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(lawyerimage)),
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 16, 0, 4),
                                child: Text(
                                  fullName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 1, 0, 2),
                                child: const Text(
                                  'Child Advocate',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 1, 0, 0),
                                child: Text(
                                  location,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Divider(
                    color: Color(0xFFD9D9D9),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 90),
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
                        Expanded(
                          child: Image.asset(
                            'assets/lawfirm.png',
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
                          title: Text(email),
                        ),
                        ListTile(
                          leading: Image.asset('assets/call.png'),
                          title: Text(phone.toString()),
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
                            'Speciality',
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
                                      borderRadius: BorderRadius.circular(20)),
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
                                      borderRadius: BorderRadius.circular(20)),
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
                                      borderRadius: BorderRadius.circular(20)),
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
                ],
              ),
            ),
          ),
        ));
  }
}
