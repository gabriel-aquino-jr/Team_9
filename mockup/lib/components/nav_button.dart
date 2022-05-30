import 'package:flutter/material.dart';

enum BtnType { text, outline }

class NavBtn extends StatelessWidget {
  const NavBtn(
      {Key? key, this.btnType, required this.label, required this.route})
      : super(key: key);

  final BtnType? btnType;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    if (btnType == BtnType.text) {
      return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ));
    } else {
      return Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      );
    }
  }
}
