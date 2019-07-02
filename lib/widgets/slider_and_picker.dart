import 'package:flutter/material.dart';
import 'dart:math';

typedef void PickerCallback(Color color);
typedef void SliderCallback(int number);

class SliderAndPicker extends StatefulWidget {
  final double width;
  final double height;
  final PickerCallback onColorUpdate;
  final SliderCallback onNumberUpdate;

  const SliderAndPicker(
      {Key key, this.width, this.height, this.onColorUpdate, this.onNumberUpdate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SliderAndPickerState();
  }
}

class _SliderAndPickerState extends State<SliderAndPicker> {
  Circle _slider;
  Circle _picker;

  bool _isSliding;
  bool _isPicking;

  Color _color;
  double _angleSlider = 180.0;
  double _anglePicker = 180.0;

  List<Color> _colors = [
    Color(0XFFFCC00F), // yellow
    Color(0XFFFCC00F), // yellow
    Color(0XFFFD7E46), // orange
    Color(0XFFDA668D), // pink
    Color(0XFFA074D3), // purple
    Color(0XFF56B8ED), // blue
    Color(0XFF56B8ED), // blue
  ];
  List<double> _stops = [0.0, 0.35, 0.425, 0.5, 0.575, 0.65, 1.0];

  @override initState() {
    super.initState();
    _color = getColor(_anglePicker);
    widget.onColorUpdate(_color);
    widget.onNumberUpdate((_angleSlider - _angleSlider * _stops[_stops.length - 2]).round());
    SweepGradient gradient = SweepGradient(
      center: FractionalOffset.center,
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: _colors,
      stops: _stops,
     );

    Paint gradientPaint = new Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
        Rect.fromCircle(center: Offset(widget.height / 2, widget.height / 2), radius: widget.height / 2 - (widget.width * 1 / 4),)
      );
    _slider = Circle(
      offset: Offset(widget.height / 2, widget.height / 2),
      radius: widget.height / 2 - (widget.width * 1 / 8),
      paint: Paint()
        ..color = Color(0XFFF0F2F7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 50
    );
    _picker = Circle(
      offset: Offset(widget.height / 2, widget.height / 2),
      radius: widget.height / 2 - (widget.width * 1 / 4),
      paint: gradientPaint 
    );
  }

  void _onPanStart(DragStartDetails details, Circle slider, Circle picker) {
    RenderBox box = context.findRenderObject();
    Offset click = box.globalToLocal(details.globalPosition);

    double dx = pow(click.dx - picker.offset.dx, 2);
    double dy = pow(click.dy - picker.offset.dy, 2);

    bool clickOnPicker = (dx + dy) < pow(picker.radius + picker.paint.strokeWidth / 2, 2);

    dx = pow(click.dx - slider.offset.dx, 2);
    dy = pow(click.dy - slider.offset.dy, 2);
    bool clickOnSlider = (dx + dy) < pow(slider.radius + slider.paint.strokeWidth / 2, 2)
      && (dx + dy) >= pow(slider.radius - slider.paint.strokeWidth / 2, 2);

    setState(() {
      _isPicking = clickOnPicker;
      _isSliding = clickOnSlider;
    });

  }

  void _onPanUpdate(DragUpdateDetails details, Circle slider, Circle picker) {
    RenderBox box = context.findRenderObject();
    Offset click = box.globalToLocal(details.globalPosition);

    if (_isSliding) {
      double distanceX = click.dx - slider.offset.dx;
      double distanceY = click.dy - slider.offset.dy;
      double _angle = atan(distanceY / distanceX) * 180 / pi + 180;
      setState(() {
        _angleSlider = _angle;
      });

      widget.onNumberUpdate((_angle - _angle * _stops[_stops.length - 2]).round());
    }

    if (_isPicking) {
      double distanceX = click.dx - picker.offset.dx;
      double distanceY = click.dy - picker.offset.dy;
      
      double _angle = atan(distanceY / distanceX) * 180 / pi + 180;
      Color color = getColor(_angle);

      setState(() {
        _anglePicker = _angle;
        _color = color;
      });

      widget.onColorUpdate(color);
    }
  }

  getColor(double angle) {
    double stop = angle / 360;
    for( var i = 0 ; i < _stops.length - 1; i++ ) { 
      if (_stops[i] <= stop && stop <= _stops[i + 1]) {
        return Color.lerp(_colors[i], _colors[i + 1], 1 - (_stops[i + 1] - stop) / (_stops[i + 1] - _stops[i]));
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      width: widget.width,
      height: widget.height,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
          onPanStart: (DragStartDetails details) => _onPanStart(details, _slider, _picker),
          onPanUpdate: (DragUpdateDetails details) => _onPanUpdate(details, _slider, _picker),
          child: CustomPaint(
            painter: SliderAndPickerPainter(
              slider: _slider,
              picker: _picker,
              color: _color,
              angleSlider: _angleSlider,
              anglePicker: _anglePicker
            ),
          ),
        ),
      ),
    );
  }
}

class SliderAndPickerPainter extends CustomPainter {

  final Circle slider;
  final Circle picker;
  final Color color;
  final double angleSlider;
  final double anglePicker;

  SliderAndPickerPainter({@required this.slider, @required this.picker, @required this.color, @required this.angleSlider, @required this.anglePicker, });

  @override
  void paint(Canvas canvas, Size size) {
    RadialGradient shadowOutside = new RadialGradient(
      colors: <Color>[
        Colors.white.withOpacity(0.5),
        Color(0XFFEAEBF1),
      ],
      stops: [
        0.98,
        1.0,
      ],
    );

    Paint outside = new Paint()
        ..color = Colors.blue
        ..shader = shadowOutside.createShader(
          Rect.fromCircle(center: Offset(size.height / 2, size.height / 2), radius: size.height / 2,)
        )
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.height / 2, size.height / 2), size.height / 2, outside);

    canvas.drawCircle(slider.offset, slider.radius, Paint()
        ..color = Color(0XFFF0F2F7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12);
    canvas.drawCircle(picker.offset, picker.radius, picker.paint);

    RadialGradient borderGradient = new RadialGradient(
      colors: <Color>[
        Colors.transparent,
        Colors.black.withOpacity(0.05),
        Colors.black.withOpacity(0.08),
      ],
      stops: [
        0.9,
        0.98,
        1.0,
      ],
    );

    Paint border = new Paint()
        ..shader = borderGradient.createShader(
          Rect.fromCircle(center: Offset(size.height / 2, size.height / 2), radius: size.height / 2 - (size.width * 1 / 4),)
        )
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;

    canvas.drawCircle(picker.offset, picker.radius, border);

    double radian = angleSlider * pi / 180;

    // double x = radius * cos(angle in radian) + dx (Offset(dx, dy));
    // double y = radius * sin(angle in radian) + dy (Offset(dx, dy));
    double xLight = (size.height / 2 - (size.width * 1 / 8)) * cos(radian) + (size.height / 2);
    double yLight = (size.height / 2 - (size.width * 1 / 8)) * sin(radian) + (size.height / 2);

    Paint lightPaint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.height / 2, size.height / 2), radius: size.height / 2 - (size.width * 1 / 8)), 
      0.0, 
      pi * 2 * (angleSlider / 360), 
      false, 
      lightPaint);

    Paint cursorSlider = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = new Path();
    path.addOval(Rect.fromCircle(center: Offset(xLight, yLight), radius: 18));
    canvas.drawShadow(path, Colors.black, 2, false);

    canvas.drawCircle(Offset(xLight, yLight), 18, cursorSlider);

    radian = anglePicker * pi / 180;

    Paint cursorPicker = new Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    double xColor = (size.height / 2 - (size.width * 1 / 4) - 35) * cos(radian) + (size.height / 2);
    double yColor = (size.height / 2 - (size.width * 1 / 4) - 50) * sin(radian) + (size.height / 2);
    canvas.drawCircle(Offset(xColor, yColor), 20, cursorPicker);
    canvas.drawCircle(Offset(xColor, yColor), 5, cursorPicker..color = Colors.white.withOpacity(0.7)..strokeWidth = 19);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Circle {
  final Offset offset;
  final double radius;
  final Paint paint;
  final String message;

  Circle({this.offset, this.radius, this.paint, this.message});
}