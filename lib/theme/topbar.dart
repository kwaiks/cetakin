import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 175.0,
      ),
      painter: CurvePainter(),
    );
  }
}

class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    Rect rect = new Rect.fromCircle(
      center: new Offset(165.0, 55.0),
      radius: 180.0,
    );
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Color(0xFF6DD5ED),
        Color(0xFF2193B0)
      ],
      stops: [
        0.5,
        1.0
      ]
    );
    Path path = Path();
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    canvas.drawPath(path, paint);
    
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return oldDelegate != this;
  }
}