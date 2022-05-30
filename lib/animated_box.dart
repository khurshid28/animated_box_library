library animated_box;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedBox extends StatefulWidget {
  double? width;
  double? height;
  Widget? child;
  Duration? duration;
  Curve? curve;
  Color? doorColor;

  AnimatedBox(
      {Key? key,
      this.width,
      this.height,
      this.child,
      this.doorColor,
      this.duration,
      this.curve})
      : super(key: key) {
    height = height ?? 100;
    duration = duration ?? const Duration(seconds: 1);
    curve = curve ?? Curves.linear;
    doorColor = doorColor ?? Colors.black;
  }

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.duration,
        value: widget.height! * 0.5,
        lowerBound: 0,
        upperBound: widget.height! * 0.5)
      ..addListener(() {
        // _animationController!.forward();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            if (_animationController!.status == AnimationStatus.forward ||
                _animationController!.status == AnimationStatus.completed) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
          },
          child: SizedBox(
            width: widget.width ?? size.width,
            height: widget.height,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widget.width ?? size.width,
                  height: widget.height,
                  child: widget.child ??
                      const Text(
                        "Hello,World!!!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                ),
                Positioned(
                  top:-1* _animationController!.value,
                  child: Container(
                    color: widget.doorColor,
                    width: widget.width ?? size.width,
                    height: widget.height! / 2,
                  ),
                ),
                Positioned(
                  bottom: -1*  _animationController!.value ,
                  child: Container(
                    color: widget.doorColor,
                    width: widget.width ?? size.width,
                    height: widget.height! / 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
