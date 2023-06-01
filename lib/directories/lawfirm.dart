// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advocatus/home/drawer.dart';
import 'package:advocatus/directories/lawfirm_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Lawfirm extends StatefulWidget {
  const Lawfirm({super.key});

  @override
  State<Lawfirm> createState() => _LawfirmState();
}

class _LawfirmState extends State<Lawfirm> {
  final Stream<QuerySnapshot> _lawfirmStream =
      FirebaseFirestore.instance.collection('lawfirms').snapshots();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String name = data['name'];
    String legal = data['legal'];
    String location = data['location'];
    String lfimage = data['image'];
    String flimage = data['flimage'];
    String flname = data['flname'];
    String fllocation = data['fllocation'];
    String flposition = data['flposition'];
    String slimage = data['slimage'];
    String slname = data['slname'];
    String sllocation = data['sllocation'];
    String slposition = data['slposition'];
    String lat = data['lat'];
    String lang = data['lang'];
    return MaterialApp(
      routes: {
        '/mapscreen': (context) => MapScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context); // pop back to previous page
          return false; // return false to prevent closing the app
        },
        child: Scaffold(
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
                'Lawfirm',
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: Column(
                    children: [
                      //Column for the lawfirms profile
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 100,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(lfimage),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 16, 0, 4),
                                        child: Text(
                                          name,
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
                                          legal,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 1, 0, 0),
                                        child: Text(
                                          location,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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

                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/downarrow.png'),
                      ),
                      Column(children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xFFBD905A),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
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
                                      image: NetworkImage(flimage),
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
                                        flname,
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
                                        flposition,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 1, 0, 5),
                                      child: Text(
                                        fllocation,
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
                        ),
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/downarrow.png'),
                        ),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
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
                                      image: NetworkImage(slimage)),
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
                                        slname,
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
                                        slposition,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 1, 0, 0),
                                      child: Text(
                                        sllocation,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )),
                            const Expanded(
                              flex: 1,
                              child: Icon(Icons.more_horiz),
                            ),
                          ]),
                        ),
                      ]),

                      SizedBox(
                        height: 10,
                      ),

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
                                  Map<String, dynamic> datas =
                                      document.data()! as Map<String, dynamic>;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(right: 4),
                                            foregroundDecoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF242632),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/Group.png'))),
                                            child: Image.asset(
                                              'assets/map.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(right: 4),
                                            foregroundDecoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF242632),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/lawfirm.png'))),
                                            child: Image.asset(
                                              'assets/map.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => Navigator.pushNamed(
                                                context, '/mapscreen',
                                                arguments: datas),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              foregroundDecoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF242632),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/map.png'))),
                                              child: Image.asset(
                                                'assets/map.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
