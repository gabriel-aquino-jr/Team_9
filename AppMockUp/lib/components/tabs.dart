import 'package:flutter/material.dart';
import 'package:mockup/utilities/palette.dart';

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
  Widget child;

  TabInfo({
    required this.tabLabel,
    required this.child,
  });
}

class Tabs extends StatefulWidget {
  const Tabs({Key? key, required this.children}) : super(key: key);
  final List<TabInfo> children;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.children.length, vsync: this);
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    // Tab controller controls tabs. the length must match the current tabs.
    return Center(
      child: Column(children: <Widget>[
        SizedBox(
          height: 1,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Palette.lightGreen,
            border: Border(
                left: BorderSide(
                    width: 10,
                    color: Palette.darkGreen,
                    style: BorderStyle.solid)),
          ),
          // Tab bar displays the navigation for the tabs. The index of tabbar will be used in the TabBarView.
          child: TabBar(
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.lightBlue,
              shadows: [
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 6, 50, 25),
                ),
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
            // This function retrives the tab label from myTabs.
            labelPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width /
                    widget.children.length /
                    1.5),
            isScrollable: true,
            controller: _tabController,
            tabs: widget.children.map((TabInfo label) {
              return Center(child: label.tabLabel);
            }).toList(),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        // Flexible is required here so elements do not get an infinite width in the column.
        Flexible(
            // TabBarView displays the content of the currently selected tab by index.
            child: TabBarView(
          // This function retrives the tab centent from myTabs. The index is protected by the List structure.
          controller: _tabController,
          children: widget.children.map((TabInfo content) {
            return content.child;
          }).toList(),
        )),
      ]),
    );
  }
}
