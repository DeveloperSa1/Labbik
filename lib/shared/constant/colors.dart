import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



// COLOR3


class LightColors  {
  static const Color kLightYellow = Color(0xFFFFF9EC);
  static const Color kLightYellow2 = Color(0xFFFFE4C7);
  static const Color kDarkYellow = Color(0xFFF9BE7C);
  static const Color kPalePink = Color(0xFFFED4D6);

  static const Color kRed = Color(0xFFE46472);
  static const Color kLavender = Color(0xFFD5E4FE);
  static const Color kBlue = Color(0xFF6488E4);
  static const Color kLightGreen = Color(0xFFD9E6DC);
  static const Color kGreen = Color(0xFF309397);

  static const Color kDarkBlue = Color(0xFF0D253F);
}

// Colors 2 


const Color kYellowLight = Color(0xFFFFF7EC);
const Color kYellow = Color(0xFFFAF0DA);
const Color kYellowDark = Color(0xFFEBBB7F);

const Color kRedLight = Color(0xFFFCF0F0);
const Color kRed = Color(0xFFFBE4E6);
const Color kRedDark = Color(0xFFF08A8E);

const Color kBlueLight = Color(0xFFEDF4FE);
const Color kBlue = Color(0xFFE1EDFC);
const Color kBlueDark = Color(0xFFC0D3F8);



// App Colors.
Color color1 = HexColor('#181d51');
Color secondryColor = Colors.indigo[200]!; // 5856d6
Color color2 = HexColor('#4657b1');
Color white = HexColor('#EBECF1');
Color black = HexColor('#000000');
Color blue = HexColor('#3BA3D8');
Color green = HexColor('#90C54F');
Color yellow = HexColor('#F8D539');
Color orange = HexColor('#F39B3D');
Color indigo = HexColor('#181d51');
Color lightIndigo = Colors.indigo.withOpacity(0.2);
// Gradiant

/////////// GRADIENT COLOR
Color first = HexColor('#3f0081');
Color second = HexColor('#4b3987');
Color third = HexColor('#6e61ab');
Color forth = HexColor('#928fce');
Color fifth = HexColor('#aab1e5');

LinearGradient primaryGradient = LinearGradient(
  colors: <Color>[first, second, third, forth, fifth],
  // stops: <double>[0.0, 1.0],
  // begin: Alignment.topCenter,
  // end: Alignment.bottomCenter,
);

LinearGradient gradient1 = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.60),
    Colors.white.withOpacity(0.10),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient borderGradient1 = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.60),
    Colors.white.withOpacity(0.10),
    Colors.purpleAccent.withOpacity(0.05),
    Colors.purpleAccent.withOpacity(0.60),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.39, 0.40, 1.0],
);

LinearGradient gradient3 = LinearGradient(
  begin: FractionalOffset.topCenter,
  colors: <Color>[HexColor("#a7b2fd"), HexColor("#c1a0fd")],
);

LinearGradient gradient2 = LinearGradient(
  colors: [Color(0xff0a0d1d), Color(0xff064170)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient glassGradient = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.60),
    Colors.white.withOpacity(0.10),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
