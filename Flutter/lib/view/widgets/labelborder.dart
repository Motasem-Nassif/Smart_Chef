import 'package:flutter/material.dart';

class LabelOnBorder extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Widget? child;
  final String label;

  const LabelOnBorder({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.child,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width ?? 200,
          height: height ?? 200,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          child: child,
        ),
        Positioned(
          top: -6,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
