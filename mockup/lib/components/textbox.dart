import 'package:flutter/material.dart';
import 'package:mockup/utilities/palette.dart';

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
  mainTitle,
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
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700);
  }
  if (style == Style.mainTitle) {
    return TextStyle(
        fontSize: 40, fontWeight: FontWeight.bold, color: Palette.darkred);
  } else if (style == Style.header) {
    return TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey.shade700);
  } else if (style == Style.link) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 84, 133, 198),
      shadows: [
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 2.0,
          color: Color.fromARGB(255, 15, 68, 38),
        ),
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 1.0,
          color: Color.fromARGB(255, 14, 56, 32),
        ),
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 1.0,
          color: Color.fromARGB(122, 14, 62, 46),
        )
      ],
    );
  } else if (style == Style.body) {
    return TextStyle(
        fontSize: 34, fontWeight: FontWeight.bold, color: Colors.grey.shade700);
  } else if (style == Style.table) {
    return TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 6, 4, 94));
  } else {
    return TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.shade700);
  }
}
