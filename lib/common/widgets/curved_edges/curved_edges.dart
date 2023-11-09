import 'package:flutter/material.dart';

class TCustomCurvedEdges extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstFCurve = Offset(0, size.height - 20);
    final firstLCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstFCurve.dx, firstFCurve.dy, firstLCurve.dx, firstLCurve.dy);

    final secondFCurve = Offset(0, size.height - 20);
    final secondLCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFCurve.dx, secondFCurve.dy, secondLCurve.dx, secondLCurve.dy);

    final thirdFCurve = Offset(size.width, size.height - 20);
    final thirdLCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFCurve.dx, thirdFCurve.dy, thirdLCurve.dx, thirdLCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}