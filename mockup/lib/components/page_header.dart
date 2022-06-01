import 'package:flutter/material.dart';
import 'package:mockup/pages/login.dart';
import 'package:mockup/provider/button_taplistener.dart';
import 'package:mockup/utilities/palette.dart';
import 'package:provider/provider.dart';

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
    // final darkmodeToggle = Provider.of<ButtonTapListenerClass>(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 29,
              color: Palette.lightBlue,
              shadows: [
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 6, 50, 25),
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(123, 3, 63, 42),
                )
              ],
            ),
          ),
          elevation: 0, // this disables the shadow
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror,
              colors:
                  // (darkmodeToggle.isClicked)
                  //     ?
                  // <Color>[
                  //     Theme.of(context).primaryColorDark,
                  //     Theme.of(context).primaryColorDark,
                  //     Theme.of(context).primaryColorDark,
                  //     Theme.of(context).primaryColorDark,
                  //     Theme.of(context).primaryColor,
                  //     Theme.of(context).primaryColorLight,
                  //     Theme.of(context).backgroundColor,
                  //   ]
                  // :
                  <Color>[
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorLight,
                Theme.of(context).backgroundColor,
              ],
            )),
          ),
          actions: [
            // NavBtn(label: 'Logout', route: LoginDemo.route),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, LoginDemo.route),
                icon: Icon(Icons.exit_to_app)),
            // IconButton(
            //     onPressed: () {
            //       darkmodeToggle.clickEvent();
            //     },
            //     icon: const Icon(
            //       Icons.lightbulb,
            //     ))
          ],
          // Todo make it so not every app bar needs a logout.
        ),
        body: SafeArea(
          child: widget.body,
        ));
  }
}
