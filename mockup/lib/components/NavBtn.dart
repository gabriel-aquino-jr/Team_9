import 'package:flutter/material.dart';

class NavBtn extends StatelessWidget {
  const NavBtn({Key? key, required this.label, required this.route})
      : super(key: key);

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    // Tab controller controls tabs. the length must match the current tabs.
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
