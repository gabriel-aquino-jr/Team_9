import 'package:flutter/material.dart';

class FancyText extends StatefulWidget {
  const FancyText({Key? key, required this.ftext, required this.style})
      : super(key: key);

  final String ftext;
  final Style? style;

  @override
  State<FancyText> createState() => _FancyTextState();
}

enum Style {
  button,
  header,
  link,
  body,
  table,
  base,
}

class _FancyTextState extends State<FancyText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.ftext, style: chooseStyle(widget.style!));
  }
}

TextStyle chooseStyle(Style style) {
  if (style == Style.button) {
    return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 6, 4, 94));
  } else if (style == Style.header) {
    return const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 6, 4, 94));
  } else if (style == Style.link) {
    return const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Color.fromARGB(255, 85, 132, 194));
  } else if (style == Style.body) {
    return const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 6, 4, 94));
  } else if (style == Style.table) {
    return const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 6, 4, 94));
  } else {
    return const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 84, 83, 156));
  }
}
