import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';

// By passing the property using this format we can add tabs where FormTabs is called. For Example:
// FormTabs(
//   myTabs: <TabInfo>[
//     TabInfo(
//         tabLabel: Tab(text: "Forms"),
//         content: Text("This is where form content appears")),
//     TabInfo(tabLabel: Tab(text: "Calendar"), content: Calendar()),

// Please Note: Because TabBar and TabBarView match together using their index, this class prevents the index from mixing up.
class TabInfo {
  Widget tabLabel;
  Widget content;

  TabInfo({
    required this.tabLabel,
    required this.content,
  });
}

class Tabs extends StatelessWidget {
  const Tabs({Key? key, required this.myTabs}) : super(key: key);

  final List<TabInfo> myTabs;

  @override
  Widget build(BuildContext context) {
    // Tab controller controls tabs. the length must match the current tabs.
    return DefaultTabController(
      length: myTabs.length,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(children: <Widget>[
          Container(
            color: Colors.blue,
            // Tab bar displays the navigation for the tabs. The index of tabbar will be used in the TabBarView.
            child: TabBar(
              // This function retrives the tab label from myTabs.
              tabs: myTabs.map((TabInfo label) {
                return Center(child: label.tabLabel);
              }).toList(),
            ),
          ),
          // Flexible is required here so elements do not get an infinite width in the column.
          Flexible(
              // TabBarView displays the content of the currently selected tab by index.
              child: TabBarView(
            // This function retrives the tab centent from myTabs. The index is protected by the List structure.
            children: myTabs.map((TabInfo content) {
              return content.content;
            }).toList(),
          )),
        ]),
      ),
    );
  }
}
