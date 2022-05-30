import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';
import 'package:mockup/components/tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Tabs(
          myTabs: <TabInfo>[
            TabInfo(
                tabLabel: Tab(text: "Forms"),
                content: Column(
                  children: [
                    Text("This is where form content appears"),
                    Text("asdfasfd")
                  ],
                )),
            TabInfo(
                tabLabel: Tab(text: "Details"),
                content: Column(
                  children: [
                    Text("Date, Time, Type, Where"),
                    Text("Delete"),
                  ],
                )),
            TabInfo(
                tabLabel: Tab(
                  text: "New Appointment",
                ),
                content: Tabs(
                  myTabs: [
                    TabInfo(
                        tabLabel: Tab(text: "Type"),
                        content: Column(
                          children: [
                            Text("Writen Test, Road Test"),
                            Text("Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Location"),
                        content: Column(
                          children: [
                            Text(
                                "Moncton(available), Sackville(not available), "),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Date"),
                        content: Column(
                          children: [
                            Text("Calendar"),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Time"),
                        content: Column(
                          children: [
                            Text(
                                "Date: , Times Available: (9:30, 10:30, ... )"),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Review"),
                        content: Column(
                          children: [
                            Text(
                                "Type: RoadTest, Where: Barhust, When: Date / Time"),
                            Text("Prev, Submit"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Confirmed"),
                        content: Column(
                          children: [
                            Text("For: User, In: Bathurst, At: Date / Time"),
                            Text("Back"),
                          ],
                        )),
                  ],
                )),
            TabInfo(
              tabLabel: Tab(text: "Calendar"),
              content: Calendar(),
            ),
          ],
        ),
      ),
    );
  }
}
