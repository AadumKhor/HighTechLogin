import 'dart:ui';
import 'dart:math' as math;
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
      this.buttonInactiveColor = const Color(0xff000000),
      this.buttonActiveColor = const Color(0xff57ffe3),
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
  final double containerSize = 10.0;
  // Path _path;

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
    // _path = drawPath();
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
              dotColor: widget.buttonActiveColor, fraction: _controller),
          child: Container(
            width: widget.minWidth + 10.0,
            height: widget.minHeight + 10.0,
          ),
        ),
        AnimatedBuilder(
            animation: _controller,
            child: Transform(
              transform: Matrix4.identity()..rotateZ(math.pi / 4),
              child: Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                    color: widget.buttonActiveColor, shape: BoxShape.rectangle),
              ),
            ),
            builder: (context, child) {
              double xValue = 0.0, yValue = 0.0;
              double value = _controller.value;
              if (_controller.value <= 0.25) {
                xValue = ((widget.minWidth) * (_controller.value / 0.25)) -
                    widget.minWidth / 2;
                yValue = -(widget.minHeight / 2) - containerSize;
              } else if (value > 0.25 && value <= 0.5) {
                xValue = widget.minWidth / 2 + containerSize;
                yValue = ((widget.minHeight) * (value - 0.25) / .25) -
                    widget.minHeight / 2;
              } else if (value > 0.5 && value <= 0.75) {
                yValue = widget.minHeight / 2 + containerSize / 2;
                xValue = widget.minWidth / 2 -
                    ((widget.minWidth) * (value - 0.5) / .25);
              } else {
                xValue = -widget.minWidth / 2 - containerSize / 4;
                yValue = widget.minHeight / 2 -
                    ((widget.minHeight) * (value - 0.75) / .25);
              }

              return Transform(
                transform: Matrix4.identity()..translate(xValue, yValue, 0),
                child: child,
              );
            }),
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
  final Color dotColor;

  LinePainter({@required this.fraction, @required this.dotColor})
      : super(repaint: fraction);

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = dotColor.withAlpha(150)
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    double topLineFraction,
        rightLineFraction,
        bottomLineFraction,
        leftLineFraction;
    double value = fraction.value;

    if (value <= 0.25) {
      topLineFraction = value / .25;
      int alpha = (255 * topLineFraction).floor();

      canvas.drawLine(
          Offset(0.0, 0.0),
          Offset(size.width * topLineFraction, 0.0),
          _paint..color.withAlpha(alpha));
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
