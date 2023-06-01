import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'assets/event2.png',
            image_caption: 'shirt',
          ),
          Category(
            image_location: 'assets/event1.png',
            image_caption: 'dress',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({required this.image_location, required this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Expanded(
          child: Column(
            children: [
              Expanded(child: Image.asset(image_location)),
              Expanded(child: Text(image_caption)),
            ],
          ),
          // child: ListTile(
          //     title: Image.asset(
          //       image_location,
          //       width: 280.0,
          //       height: 280.0,
          //     ),
          //     subtitle: Container(
          //       alignment: Alignment.topCenter,
          //       child: Text(
          //         image_caption,
          //         style: new TextStyle(fontSize: 12.0),
          //       ),
          //     )),
        ),
      ),
    );
  }
}
