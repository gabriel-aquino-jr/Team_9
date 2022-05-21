import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';

class TabInfo {
  Widget tabLabel;
  Widget content;

  TabInfo({
    required this.tabLabel,
    required this.content,
  });
}

class FormTabs extends StatefulWidget {
  const FormTabs({Key? key}) : super(key: key);

  @override
  State<FormTabs> createState() => _FormTabsState();
}

class _FormTabsState extends State<FormTabs> {
  final List<TabInfo> myTabs = <TabInfo>[
    TabInfo(
        tabLabel: Tab(text: "Forms"),
        content: Text("This is where form content appears")),
    TabInfo(tabLabel: Tab(text: "Calendar"), content: Calendar()),
  ];

  @override
  Widget build(BuildContext context) {
    // tab controller controls tabs
    return DefaultTabController(
      length: myTabs.length,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(children: <Widget>[
          Container(
            color: Colors.blue,
            child: TabBar(
              tabs: myTabs.map((TabInfo label) {
                return Center(child: label.tabLabel);
              }).toList(),
            ),
          ),
          Flexible(
              child: TabBarView(
            children: myTabs.map((TabInfo content) {
              return content.content;
            }).toList(),
          )),
        ]),
      ),
    );
  }
}
