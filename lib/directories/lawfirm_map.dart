// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};

  final Stream<QuerySnapshot> _lawfirmStream =
      FirebaseFirestore.instance.collection('lawfirms').snapshots();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String lat = data['lat'];
    String lang = data['lang'];
    String name = data['name'];
    String phone = data['phone'];
    String opentime = data['opentime'];
    String email = data['email'];
    String po = data['po'];

    void _onMapCreated(GoogleMapController controller) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(
              double.parse(lat),
              double.parse(lang),
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(
              title: name,
              snippet: 'Law firm',
            ),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 27,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 40),
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Image.asset(
        //         'assets/log.png',
        //         height: 150,
        //         width: 150,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.57,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      mapType: MapType.normal,
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(lat), double.parse(lang)),
                        zoom: 13,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Firm:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      children: [
                        Text(
                          'Contact:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              phone,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              po,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      children: [
                        Text(
                          'Open:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: Text(
                            opentime,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
