// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advocatus/directories/lawyerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class trial extends StatefulWidget {
  const trial({super.key});

  @override
  State<trial> createState() => _trialState();
}

class _trialState extends State<trial> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _uid;
  String? _name;
  String? _email;
  String? _location;
  String? _lawyerImage;
  String? _speciality;
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
    // print('user.emal ${user.email}');
    final DocumentSnapshot lawyerDoc =
        await FirebaseFirestore.instance.collection('lawyers').doc().get();
    setState(() {
      _name = lawyerDoc.get('name');
      _email = lawyerDoc.get('email');
      _location = lawyerDoc.get('location');
      _speciality = lawyerDoc.get('speciality');
      _lawyerImage = lawyerDoc.get('image');
    });

    // potential Error
    //final Future<DocumentSnapshot<Map<String, dynamic>>> userDoc =
    //FirebaseFirestore.instance.collection('users').doc(_uid).get();
  }

  // final name = '';
  // final location = '';
  // final speciality = '';
  // final image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Lawyers',
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
        child: Column(
          children: [
            //Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                          hintText: 'Search Lawyers',
                          hintStyle: TextStyle(fontStyle: FontStyle.italic),
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
            Divider(
              color: Color.fromARGB(255, 245, 235, 247),
              thickness: 5,
            ),

            //Search bar ends here

            StreamBuilder<QuerySnapshot>(
              stream: db.collection('lawyers').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("Loading...");
                    default:
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Color.fromARGB(255, 245, 235, 247),
                            thickness: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              // onTap: () {
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (context) => LawyerProfile(),
                              //     ),
                              //   );
                              // },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Row(children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 80,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot
                                                  .data!.docs[index]["image"] ??
                                              'https://th.bing.com/th/id/OIP.od2CBW4Pu7yx6v7I9gb6SwHaHa?pid=ImgDet&rs=1'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 16, 0, 4),
                                          child: Text(
                                            snapshot.data!.docs[index]['name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 1, 0, 2),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['speciality'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 1, 0, 0),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['location'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Icon(Icons.more_horiz),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
