import 'package:flutter/material.dart';

class FancyText extends StatefulWidget {
  const FancyText({Key? key, required this.ftext}) : super(key: key);

  final String ftext;

  @override
  State<FancyText> createState() => _FancyTextState();
}

class _FancyTextState extends State<FancyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.ftext,
      style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 6, 4, 94)),
    );
  }
}
