// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import

import 'dart:ui';

import 'package:flutter/material.dart';

class Directories extends StatefulWidget {
  const Directories({super.key});

  @override
  State<Directories> createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                child: Text(
                  'Directories',
                  style: TextStyle(fontSize: 19),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ExpansionTile(
                  title: Text(
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
                      ),
                      children: [
                        ListTile(
                          title: Text('Law Firms'),
                        ),
                        ListTile(
                          title: Text('Lawyers'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      backgroundColor: Color(0xFFBD905A),
                      title: Text(
                        'Govt Departments',
                      ),
                      children: [
                        ExpansionTile(
                          textColor: Colors.white,
                          title: Text(
                            'JUDICIARY',
                            style: TextStyle(
                                // color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          children: [
                            ListTile(
                              title: Text('SUPREME COURT'),
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
                              title: Text('COURT OF APPEAL'),
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
                              title: Text('CONSTITUTIONAL COURT'),
                            ),
                            ListTile(
                              title: Text('-Master'),
                            ),
                            ListTile(
                              title: Text('-Marshal to Judge'),
                            ),
                            ListTile(
                              title: Text('HIGH COURT'),
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
                          title: Text('MINISTRIES'),
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
                              title: Text('Ministry of Scienceand Technology'),
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
                          title: Text('TRIBUNALS'),
                          children: [
                            ListTile(
                              title: Text('Tax Appeal Tribunal'),
                            ),
                            ListTile(
                              title: Text('Competition & Consumer Protection'),
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
                          title: Text('LOCAL GOVERNMENT'),
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
                              title: Text('Legal Counsel - Kabwe City Council'),
                            ),
                            ListTile(
                              title: Text('Legal Counsel - Ndola City Council'),
                            ),
                            ListTile(
                              title: Text('Legal Counsel - Kitwe City Council'),
                            ),
                            ListTile(
                              title:
                                  Text('Legal Counsel - Solwezi City Council'),
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
                      ),
                      children: [
                        ListTile(
                          title: Text('FINANCIAL INSTITUTIONS'),
                        ),
                        ExpansionTile(
                          title: Text('COMMISIONS'),
                          children: [
                            ListTile(
                              title: Text('Securities and Exchange Commision'),
                            ),
                            ListTile(
                              title: Text('Electrol Commision'),
                            ),
                            ListTile(
                              title: Text('Anti Corruption Commision'),
                            ),
                            ListTile(
                              title: Text('Competition & Consumer Protection'),
                            ),
                            ListTile(
                              title: Text('Drug Enforcement Commision'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('ASSOCIATIONS'),
                          children: [
                            ListTile(
                              title: Text('Law Associations of Zambia'),
                            ),
                            ListTile(
                              title: Text('Engineering Associations of Zambia'),
                            ),
                            ListTile(
                              title:
                                  Text('Health Professions Council of zambia'),
                            ),
                            ListTile(
                              title: Text('Zambia Medical Association'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('EMBASIES/CONSULATES'),
                          children: [
                            ListTile(
                              title: Text('Director General Office'),
                            ),
                            ListTile(
                              title: Text('Passprt Office'),
                            ),
                            ListTile(
                              title: Text('View Embasis/Consulates'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('IMMIGRATION'),
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
                          title: Text('AGENCIES/STATUTORY BODIES'),
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
                              title: Text('Lusaka Water and Sewarage Company'),
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
                              title: Text('National Pensions Scheme Authority'),
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
            ],
          ),
        ),
      ),
    );
  }
}
