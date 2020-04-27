import 'dart:ui';
import 'package:flutter/material.dart';

typedef OnPressed();

class CustomLoginButton extends StatefulWidget {
  final String buttonText;
  final Color buttonInactiveColor;
  final Color buttonActiveColor;
  final OnPressed onPressed;
  final double minWidth;
  final double minHeight;

  CustomLoginButton(
      {Key key,
      @required this.buttonInactiveColor,
      this.buttonActiveColor = const Color(0xff03e9f4),
      @required this.onPressed,
      this.buttonText = "Login",
      this.minHeight = 50.0,
      this.minWidth = 150.0})
      : assert(onPressed != null),
        assert(minWidth >= 150.0, minHeight >= 50.0),
        super(key: key);

  @override
  _CustomLoginButtonState createState() => _CustomLoginButtonState();
}

class _CustomLoginButtonState extends State<CustomLoginButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1200));
    _controller.forward();
    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: LinePainter(
              color1: widget.buttonInactiveColor,
              color2: widget.buttonActiveColor,
              fraction: _controller),
          child: Container(
            width: widget.minWidth + 10.0,
            height: widget.minHeight + 10.0,
          ),
        ),
        InkWell(
          onTap: widget.onPressed,
          splashColor: widget.buttonActiveColor,
          child: Container(
            height: widget.minHeight,
            width: widget.minWidth,
            color: widget.buttonInactiveColor,
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(
                    color: widget.buttonActiveColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  final Animation<double> fraction;

  final Color color1;
  final Color color2;

  LinePainter(
      {@required this.fraction, @required this.color1, @required this.color2})
      : super(repaint: fraction);

  Rect rect = new Rect.fromCircle(
    center: new Offset(165.0, 55.0),
    radius: 180.0,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // final Gradient gradient = new LinearGradient(
    //   begin: Alignment.centerLeft,
    //   end: Alignment.centerRight,
    //   colors: [color1, color2],
    //   stops: [0.1, fraction.value]
    // );
    Paint _paint = Paint()
      ..color = color2
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    double topLineFraction,
        rightLineFraction,
        bottomLineFraction,
        leftLineFraction;
    double value = fraction.value;

    if (value <= 0.25) {
      topLineFraction = value / .25;

      canvas.drawLine(
          Offset(0.0, 0.0), Offset(size.width * topLineFraction, 0.0), _paint);
    } else if (0.25 <= value && value < 0.5) {
      topLineFraction = 1.0;
      rightLineFraction = (value - 0.25) / 0.25;
      canvas.drawLine(Offset(size.width * topLineFraction, 0.0),
          Offset(size.width, size.height * rightLineFraction), _paint);
    } else if (value >= 0.5 && value < 0.75) {
      bottomLineFraction = (value - 0.5) / 0.25;
      canvas.drawLine(Offset(size.width, size.height),
          Offset(size.width * (1 - bottomLineFraction), size.height), _paint);
    } else if (value >= 0.75 && value < 1.0) {
      leftLineFraction = (value - 0.75) / .25;
      canvas.drawLine(Offset(0.0, size.height),
          Offset(0.0, size.height * (1 - leftLineFraction)), _paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
