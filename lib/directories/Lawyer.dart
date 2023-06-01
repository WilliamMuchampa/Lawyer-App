// ignore_for_file: prefer_const_constructors

import 'package:advocatus/directories/lawyerprofile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lawyer extends StatefulWidget {
  const Lawyer({super.key});

  @override
  LawyerState createState() => LawyerState();
}

class LawyerState extends State<Lawyer> {
  final Stream<QuerySnapshot> _lawyerStream =
      FirebaseFirestore.instance.collection('lawyers').snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/lawyerprofile': (context) => LawyerProfile(),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
              StreamBuilder<QuerySnapshot>(
                stream: _lawyerStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/lawyerprofile',
                              arguments: data, // pass the data as arguments
                            );
                          },
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
                                      image: NetworkImage(data['image'] ??
                                          'https://th.bing.com/th/id/OIP.od2CBW4Pu7yx6v7I9gb6SwHaHa?pid=ImgDet&rs=1'),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          2, 16, 0, 4),
                                      child: Text(
                                        data['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 1, 0, 2),
                                      child: Text(
                                        data['speciality'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 1, 0, 0),
                                      child: Text(
                                        data['location'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
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
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
