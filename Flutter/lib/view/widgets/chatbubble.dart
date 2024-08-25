import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color color;

  ChatBubble({required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChatBubblePainter(color: color),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontFamily: "Margarine"),
        ),
      ),
    );
  }
}

class ChatBubblePainter extends CustomPainter {
  final Color color;

  ChatBubblePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 10)
      ..lineTo(10, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height - 10)
      ..lineTo(size.width - 10, size.height - 10)
      ..arcToPoint(Offset(size.width, size.height), radius: Radius.circular(10))
      ..lineTo(size.width, 10)
      ..arcToPoint(Offset(size.width - 10, 0),
          radius: Radius.circular(10), clockwise: false)
      ..lineTo(10, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
