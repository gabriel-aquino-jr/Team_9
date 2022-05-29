import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';

class FormTabs extends StatefulWidget {
  const FormTabs({Key? key}) : super(key: key);

  @override
  State<FormTabs> createState() => _FormTabsState();
}

class _FormTabsState extends State<FormTabs> {
// See input demo to see if DefaultTab Controller can be moved outside the return
// - see if the tab bar, and tabbar view has a controler properties

  @override
  Widget build(BuildContext context) {
    // tab controller controls tabs
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("MyHeader"),
          // For Tab in the header
          bottom: const TabBar(
            tabs: [
              Tab(text: "Form"),
              Tab(text: 'Calendar'),
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
              child: const TabBarView(
                children: [
                  Text("My form content appears here"),
                  Calendar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
