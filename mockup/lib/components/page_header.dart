import 'package:flutter/material.dart';
import 'package:mockup/provider/button_taplistener.dart';
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
    final darkmodeToggle = Provider.of<ButtonTapListenerClass>(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0, // this disables the shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror,
              colors: (darkmodeToggle.isClicked)
                  ? <Color>[
                      Theme.of(context).primaryColorDark,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).backgroundColor,
                    ]
                  : <Color>[
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                      Theme.of(context).backgroundColor,
                    ],
            )),
          ),
          actions: [
            // NavBtn(label: 'Logout', route: LoginDemo.route),
            IconButton(
                onPressed: () {
                  darkmodeToggle.clickEvent();
                },
                icon: const Icon(
                  Icons.lightbulb,
                ))
          ],
          // Todo make it so not every app bar needs a logout.
        ),
        body: SafeArea(
          child: widget.body,
        ));
  }
}
