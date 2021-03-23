import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BallScreen extends StatefulWidget {
  final StreamController streamController;

  BallScreen({
    Key key,
    this.streamController,
  }) : super(key: key);

  @override
  BallScreenState createState() => BallScreenState();
}

class BallScreenState extends State<BallScreen> {
  final List<_Ball> _balls = List();

  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = widget.streamController.stream.listen((event) {});
  }

  @override
  void dispose() {
    _streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._balls,
      ],
    );
  }

  create<T>({
    T data,
    Offset local,
    GlobalKey from,
    GlobalKey to,
  }) {
    final RenderBox fromRenderBox = from.currentContext.findRenderObject();
    final fromOffset = local +
        Offset(
          fromRenderBox.size.width / 2,
          fromRenderBox.size.height / 2,
        );
    final begin = fromRenderBox.localToGlobal(fromOffset);

    final RenderBox toRenderBox = to.currentContext.findRenderObject();
    final toOffset = local +
        Offset(
          toRenderBox.size.width / 2,
          toRenderBox.size.height / 2,
        );
    final end = toRenderBox.localToGlobal(toOffset);

    final speed = MediaQuery.of(context).devicePixelRatio * .5;

    final ball = _Ball<T>(
      streamController: widget.streamController,
      size: 20,
      data: data,
      begin: begin,
      end: end,
      speed: speed,
    );

    _balls..add(ball);

    setState(() {});
  }
}

class _Ball<T> extends StatefulWidget {
  final StreamController streamController;
  final T data;
  final double size;
  final Offset begin;
  final Offset end;
  final double speed;

  _Ball({
    this.streamController,
    this.data,
    this.size,
    this.begin,
    this.end,
    this.speed,
  });

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<_Ball> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    final bezier = Offset(
      widget.begin.dx + (widget.end.dx - widget.begin.dx) * .5,
      min(widget.begin.dy, widget.end.dy) -
          (widget.end - widget.begin).distance / widget.speed * .5,
    );
    final distance = (widget.begin - bezier).distance.abs() +
        (bezier - widget.end).distance.abs();
    final duration = Duration(milliseconds: (distance * widget.speed).round());

    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _animation = BallAnimatable(
      bezier: bezier,
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller
      ..addListener(() {
        if (_controller.isCompleted && !_isDone) {
          _isDone = true;
          widget.streamController.sink.add(widget.data);
        }
      })
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Positioned(
        top: _animation.value.dy - widget.size / 2,
        left: _animation.value.dx - widget.size / 2,
        child: AnimatedContainer(
          width: widget.size,
          height: widget.size,
          curve: Curves.bounceIn,
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}

class BallAnimatable extends Animatable<Offset> {
  final Offset bezier;
  final Offset begin;
  final Offset end;

  BallAnimatable({
    this.bezier,
    this.begin,
    this.end,
  });

  @protected
  Offset lerp(double t) {
    assert(begin != null);
    assert(end != null);

    final s = 1 - t;
    final a = begin * s + bezier * t;
    final b = bezier * s + end * t;

    return a * s + b * t;
  }

  @override
  Offset transform(double t) {
    if (t == 0.0) return begin;
    if (t == 1.0) return end;
    return lerp(t);
  }
}
