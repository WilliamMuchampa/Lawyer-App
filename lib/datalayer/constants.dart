import 'package:flutter/material.dart';

const kPrimaryColour = Color(0xFFFFFFFF);
const kBlackColour = Colors.black;
const int kPrimaryColourInt = 0xFF5a6d40;
const kSecondaryColour = Color(0xFF53406D);
const kPrimaryLightColour = Color(0xFF653624);
const int kSecondaryColourInt = 0xFF007BB6;
const kWhiteColour = Color(0xffffffff);
const kBackgroundColour = Color(0xFF1F1F1F);
const kDividerColour = Color(0xFF282828);

const MaterialColor kMaterialSecondaryColor =
MaterialColor(kSecondaryColourInt, <int, Color>{
  50: kSecondaryColour,
  100: kSecondaryColour,
  200: kSecondaryColour,
  300: kSecondaryColour,
  400: kSecondaryColour,
  500: kSecondaryColour,
  600: kSecondaryColour,
  700: kSecondaryColour,
  800: kSecondaryColour,
  900: kSecondaryColour,
});

const MaterialColor kMaterialPrimaryColor =
MaterialColor(kPrimaryColourInt, <int, Color>{
  50: kPrimaryColour,
  100: kPrimaryColour,
  200: kPrimaryColour,
  300: kPrimaryColour,
  400: kPrimaryColour,
  500: kPrimaryColour,
  600: kPrimaryColour,
  700: kPrimaryColour,
  800: kPrimaryColour,
  900: kPrimaryColour,
});

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)
    ),
  );
}