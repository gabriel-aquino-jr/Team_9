import 'package:flutter/material.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/utilities/palette.dart';

enum BtnType { link, outline }

class NavBtn extends StatelessWidget {
  const NavBtn(
      {Key? key, this.btnType, required this.label, required this.route})
      // Above is your class constructor.
      : super(key: key);

  final BtnType? btnType; // These are the fields filled by the constructor.
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    if (btnType == BtnType.link) {
      return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: FancyText(
            ftext: label,
            style: Style.link,
            // style: TextStyle(color: Colors.blue, fontSize: 15),
          ));
    } else {
      return Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2.0, color: Palette.medGreen, style: BorderStyle.solid),
            color: Palette.darkGreen,
            borderRadius: BorderRadius.circular(20)),
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      );
    }
  }
}
