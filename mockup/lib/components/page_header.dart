import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/login.dart';

class PageHeader extends StatefulWidget {
  const PageHeader(
      {Key? key, required this.title, required this.body, this.logout})
      : super(key: key);

  final String title;
  final Widget body;
  final bool? logout;

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          NavBtn(label: 'Logout', route: LoginDemo.route),
        ],
        // Todo make it so not every app bar needs a logout.
      ),
      body: widget.body,
    );
  }
}
