import 'package:flutter/material.dart';

enum BtnType {
  text,
  outline
} // Enum isn't necesary buts its nice to have autofill passing parameter in.

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
    if (btnType == BtnType.text) {
      // Enum. Here we are making use of the Enum to check what was passed in.
      return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            label, // Here we are accesing a field. *Note* a Statefull widgets would have used: widget.label
            style: const TextStyle(color: Colors.blue, fontSize: 15),
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
