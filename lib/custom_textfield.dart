import 'package:flutter/material.dart';

typedef CustomOnSubmitted(String value);

class CustomTextfield extends StatefulWidget {
  final String fieldName;
  final CustomOnSubmitted onSubmitted;
  final TextStyle fieldStyle;
  final TextStyle textFieldStyle;
  final Color bgColor;
  final double minWidth;
  final double minHeight;

  CustomTextfield(
      {Key key,
      this.bgColor = const Color(0xff152057),
      @required this.fieldName,
      @required this.onSubmitted,
      this.minHeight = 60.0,
      this.minWidth = 220.0,
      this.fieldStyle = const TextStyle(
          color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600),
      this.textFieldStyle = const TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400)})
      : assert(fieldName != null, onSubmitted != null),
        assert(minWidth >= 220.0),
        assert(minHeight >= 60.0),
        super(key: key);

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double maxHorSlide, maxVerSlide;
  final double horPadding = 70.0, verPadding = 40.0;
  final FocusNode _focusNode = new FocusNode();
  String fieldvalue = "";

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    maxHorSlide = (widget.minWidth - horPadding) / 3;
    maxVerSlide = (widget.minHeight - verPadding) / 2;
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _controller.forward();
    }

    if (!_focusNode.hasFocus) {
      if (fieldvalue == "") {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(5.0),
      child: Container(
        width: widget.minWidth,
        height: widget.minHeight,
        decoration: new BoxDecoration(color: widget.bgColor, boxShadow: [
          BoxShadow(
              offset: Offset(0, 20),
              color: Color.fromARGB(120, 0, 0, 0),
              blurRadius: 22.0)
        ]),
        child: GestureDetector(
          onTap: () {
            if (!_focusNode.hasFocus) {
              _focusNode.requestFocus();
            }
          },
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: TextField(
                    focusNode: _focusNode,
                    style: widget.textFieldStyle,
                    autofocus: false,
                    autocorrect: false,
                    decoration: InputDecoration.collapsed(hintText: ''),
                    onSubmitted: widget.onSubmitted,
                  ),
                ),
              ),
              AnimatedBuilder(
                  animation: new CurvedAnimation(
                      parent: _controller, curve: Curves.easeOutCubic),
                  builder: (context, child) {
                    double scale = 1 - (_controller.value * 0.5);
                    double horSlide = -(_controller.value * maxHorSlide);
                    double verticalSlide = -(_controller.value * maxVerSlide);
                    return Transform(
                      transform: Matrix4.identity()
                        ..scale(scale)
                        ..translate(horSlide, verticalSlide, 0),
                      child: Center(
                        child: Text(
                          widget.fieldName,
                          style: widget.fieldStyle,
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
