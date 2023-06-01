// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:advocatus/datalayer/load.dart';
import 'package:advocatus/directories/embasies.dart';
import 'package:advocatus/directories/financialinst.dart';
import 'package:advocatus/directories/lawfirms.dart';
import 'package:advocatus/home/events.dart';
import 'package:advocatus/directories/lawyer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advocatus Directories',
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 47,
                  child: TextField(
                    cursorColor: Color(0xFFBD905A),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFBD905A),
                      ),
                      hintText: 'Search Directories',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                  child: Text(
                    'Directories',
                    style: TextStyle(fontSize: 19),
                  ),
                ),

                //Directories starts here and  the expansion listTile
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ExpansionTile(
                    title: const Text(
                      'View Directories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ExpansionTile(
                        backgroundColor: Color(0xFFBD905A),
                        title: Text(
                          'Legal Practitioners',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Lawfirms(),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                'Law Firms',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Lawyer(),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                'Lawyers',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        backgroundColor: Color(0xFFBD905A),
                        title: Text(
                          'Govt Departments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        children: [
                          ExpansionTile(
                            textColor: Colors.white,
                            title: Text(
                              'JUDICIARY',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  'SUPREME COURT',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '-Master',
                                ),
                              ),
                              ListTile(
                                title: Text('-Marshal to Judge'),
                              ),
                              ListTile(
                                title: Text('-Research Advoactes'),
                              ),
                              ListTile(
                                title: Text(
                                  'COURT OF APPEAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text('-Master'),
                              ),
                              ListTile(
                                title: Text('-Marshal to Judge'),
                              ),
                              ListTile(
                                title: Text('-Research Advoactes'),
                              ),
                              ListTile(
                                title: Text(
                                  'CONSTITUTIONAL COURT',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text('-Master'),
                              ),
                              ListTile(
                                title: Text('-Marshal to Judge'),
                              ),
                              ListTile(
                                title: Text(
                                  'HIGH COURT',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text('Registrars'),
                              ),
                              ListTile(
                                title: Text('Chief Marshal'),
                              ),
                              ListTile(
                                title: Text('IT Officers'),
                              ),
                              ListTile(
                                title: Text('-Research Advoactes'),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'MINISTRIES',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Information and Media'),
                              ),
                              ListTile(
                                title: Text(
                                    'Foreign Affairs and International Cooperation'),
                              ),
                              ListTile(
                                title: Text('Green Economy and Environment'),
                              ),
                              ListTile(
                                title: Text('Mines and Minerals Development'),
                              ),
                              ListTile(
                                title: Text('Commerce, trade and Industry'),
                              ),
                              ListTile(
                                title: Text('Transport and Logisticts'),
                              ),
                              ListTile(
                                title: Text('Agriculture'),
                              ),
                              ListTile(
                                title: Text('Ministry of Education'),
                              ),
                              ListTile(
                                title:
                                    Text('Ministry of Scienceand Technology'),
                              ),
                              ListTile(
                                title: Text('Ministry of Health'),
                              ),
                              ListTile(
                                title: Text('Ministry of Justice'),
                              ),
                              ListTile(
                                title: Text(
                                    'Ministry of Water development and Sanitation'),
                              ),
                              ListTile(
                                title: Text('Ministry of Youth, sportand Arts'),
                              ),
                              ListTile(
                                title: Text(
                                    'Ministry of Lands and Natural Resources'),
                              ),
                              ListTile(
                                title: Text('Ministry of Defence'),
                              ),
                              ListTile(
                                title: Text(
                                    'Ministry of Labour and social Security'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'TRIBUNALS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Tax Appeal Tribunal'),
                              ),
                              ListTile(
                                title:
                                    Text('Competition & Consumer Protection'),
                              ),
                              ListTile(
                                title: Text('Mines & Minerals Tribunals'),
                              ),
                              ListTile(
                                title: Text('Lands Tribunals'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'LOCAL GOVERNMENT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title:
                                    Text('Legal Counsel - Lusaka City Council'),
                              ),
                              ListTile(
                                title: Text(
                                    'Legal Counsel - Kafue Municipal Council'),
                              ),
                              ListTile(
                                title:
                                    Text('Legal Counsel - Kabwe City Council'),
                              ),
                              ListTile(
                                title:
                                    Text('Legal Counsel - Ndola City Council'),
                              ),
                              ListTile(
                                title:
                                    Text('Legal Counsel - Kitwe City Council'),
                              ),
                              ListTile(
                                title: Text(
                                    'Legal Counsel - Solwezi City Council'),
                              ),
                              ListTile(
                                title: Text(
                                    'Legal Counsel - Livingstone City Council'),
                              ),
                              ListTile(
                                title: Text(
                                    'Legal Counsel - Chongwe Municipal Council'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        backgroundColor: Color(0xFFBD905A),
                        title: Text(
                          'Institutions',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      FinancialInstitutions()),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                'FINANCIAL INSTITUTIONS',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          ExpansionTile(
                            title: Text(
                              'COMMISIONS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title:
                                    Text('Securities and Exchange Commision'),
                              ),
                              ListTile(
                                title: Text('Electrol Commision'),
                              ),
                              ListTile(
                                title: Text('Anti Corruption Commision'),
                              ),
                              ListTile(
                                title:
                                    Text('Competition & Consumer Protection'),
                              ),
                              ListTile(
                                title: Text('Drug Enforcement Commision'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'ASSOCIATIONS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Law Associations of Zambia'),
                              ),
                              ListTile(
                                title:
                                    Text('Engineering Associations of Zambia'),
                              ),
                              ListTile(
                                title: Text(
                                    'Health Professions Council of zambia'),
                              ),
                              ListTile(
                                title: Text('Zambia Medical Association'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'EMBASIES/CONSULATES',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Director General Office'),
                              ),
                              ListTile(
                                title: Text('Passprt Office'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Embasies(),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'View Embasis/Consulates',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'IMMIGRATION',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Director Generals Office'),
                              ),
                              ListTile(
                                title: Text('Passprt Office'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'AGENCIES/STATUTORY BODIES',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            children: [
                              ListTile(
                                title: Text('Zambia Revenue Authority'),
                              ),
                              ListTile(
                                title: Text(
                                    'Patents and Companies Registrations Agency'),
                              ),
                              ListTile(
                                title: Text('Zambia Bureau of Standards'),
                              ),
                              ListTile(
                                title: Text('Energy Regulaations Board'),
                              ),
                              ListTile(
                                title: Text('Director Generals Office'),
                              ),
                              ListTile(
                                title: Text('Zambia Wildlife Authority'),
                              ),
                              ListTile(
                                title: Text('Financial Intelligence Center'),
                              ),
                              ListTile(
                                title: Text('Zambia Environmental Agency'),
                              ),
                              ListTile(
                                title:
                                    Text('Lusaka Water and Sewarage Company'),
                              ),
                              ListTile(
                                title: Text('Rural Electrification agency'),
                              ),
                              ListTile(
                                title: Text('ZESCO Limited'),
                              ),
                              ListTile(
                                title: Text(
                                    'Water Resources and Management Authority'),
                              ),
                              ListTile(
                                title: Text('Parliament'),
                              ),
                              ListTile(
                                title: Text('Zambia Police Force'),
                              ),
                              ListTile(
                                title: Text('Zambia Airforce'),
                              ),
                              ListTile(
                                title: Text('Zambia army'),
                              ),
                              ListTile(
                                title:
                                    Text('Zambia Airports Corporation Limited'),
                              ),
                              ListTile(
                                title: Text('Zambia National Service'),
                              ),
                              ListTile(
                                title: Text('Zambia Railawys'),
                              ),
                              ListTile(
                                title: Text('Road Development Agency'),
                              ),
                              ListTile(
                                title: Text('Road Transport and Safety Agency'),
                              ),
                              ListTile(
                                title:
                                    Text('National Pensions Scheme Authority'),
                              ),
                              ListTile(
                                title: Text(
                                    'National Health Insurance Management Authority'),
                              ),
                              ListTile(
                                title: Text(
                                    'Zambia Information Communication Technology Authority'),
                              ),
                              ListTile(
                                title: Text('Government Printers'),
                              ),
                              ListTile(
                                title: Text('National Archives'),
                              ),
                              ListTile(
                                title: Text('Pensions and Insurance Authority'),
                              ),
                              ListTile(
                                title: Text('Public Service MicroFinance co.'),
                              ),
                              ListTile(
                                title: Text('Credit reference Bureau'),
                              )
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        backgroundColor: Color(0xFFBD905A),
                        title: Text(
                          'Others',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        children: [
                          ListTile(
                            title: Text('-Times of Zambia'),
                          ),
                          ListTile(
                            title: Text('-Zambia Daily Mail'),
                          ),
                          ListTile(
                            title: Text('-Post Newspaper'),
                          ),
                          ListTile(
                            title: Text('-The Mast'),
                          ),
                          ListTile(
                            title: Text('-COMESA'),
                          ),
                          ListTile(
                            title: Text('-Lusaka Stock Exchange'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Featured',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'View All',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: db.collection('featured').snapshots(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.43,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.all(7.0),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                            // offset:
                                            //     Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.network(
                                            snapshot.data!.docs[index]["image"],
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 0,
                                              ),
                                              title: Text(
                                                snapshot.data!.docs[index]
                                                    ["title"],
                                                maxLines: 2,
                                              ),
                                              subtitle: Text('10 min read'),
                                            )),
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(Icons.more_horiz),
                                        ),
                                      ]),
                                    );
                                  },
                                ),
                              );
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Column(
                      children: [
                        const Text(
                          'TOP COURSES',
                          style: TextStyle(
                            color: Color(0xFFBD905A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFD9D9D9),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: db.collection('topCourses').snapshots(),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.32,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(children: [
                                            Expanded(
                                              flex: 2,
                                              child: Image.network(
                                                snapshot.data!.docs[index]
                                                        ["image"] ??
                                                    'no internet',
                                                height: 80,
                                                width: 80,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: ListTile(
                                                  title: Text(snapshot.data!
                                                      .docs[index]['title']),
                                                  subtitle: Text(snapshot.data!
                                                      .docs[index]['views']),
                                                )),
                                          ]),
                                        );
                                      },
                                    ),
                                  );
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: ListTile(
                              title: Text(
                            'VIEW ALL COURSES',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.blue),
                          )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'EVENTS',
                      style: TextStyle(
                        color: Color(0xFFBD905A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: db.collection('events').snapshots(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 300,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Image.network(
                                                    snapshot.data!.docs[index]
                                                        ["image"],
                                                    height: 250,
                                                    width: 250,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['title'],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['subtitle'],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/event1.png',
                                                    height: 250,
                                                    width: 250,
                                                  ),
                                                  const Text(
                                                    'Advocacy Meetup',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Text(
                                                    'Advocacy Event, 10.06.2023',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                          }
                        }
                      },
                    ),
                    // SizedBox(
                    //   height: 300,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Column(
                    //             children: [
                    //               Image.asset(
                    //                 'assets/event2.png',
                    //                 height: 250,
                    //                 width: 250,
                    //               ),
                    //               const Text(
                    //                 'Associate Meetup',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               const Text(
                    //                 'Licensing Event, 5.03.2023',
                    //                 style: TextStyle(
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           Column(
                    //             children: [
                    //               Image.asset(
                    //                 'assets/event1.png',
                    //                 height: 250,
                    //                 width: 250,
                    //               ),
                    //               const Text(
                    //                 'Advocacy Meetup',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               const Text(
                    //                 'Advocacy Event, 10.06.2023',
                    //                 style: TextStyle(
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
