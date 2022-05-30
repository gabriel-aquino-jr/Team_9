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
          children: <TabInfo>[
            TabInfo(
                tabLabel: Tab(text: "Forms"),
                child: Column(
                  children: [
                    Text("This is where form content appears"),
                    Text("asdfasfd")
                  ],
                )),
            TabInfo(
                tabLabel: Tab(text: "Details"),
                child: Column(
                  children: [
                    Text("Date, Time, Type, Where"),
                    Text("Delete"),
                  ],
                )),
            TabInfo(
                tabLabel: Tab(
                  text: "New Appointment",
                ),
                child: Tabs(
                  children: [
                    TabInfo(
                        tabLabel: Tab(text: "Type"),
                        child: Column(
                          children: [
                            Text("Writen Test, Road Test"),
                            Text("Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Location"),
                        child: Column(
                          children: [
                            Text(
                                "Moncton(available), Sackville(not available), "),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Date"),
                        child: Column(
                          children: [
                            Text("Calendar"),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Time"),
                        child: Column(
                          children: [
                            Text(
                                "Date: , Times Available: (9:30, 10:30, ... )"),
                            Text("Prev, Next"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Review"),
                        child: Column(
                          children: [
                            Text(
                                "Type: RoadTest, Where: Barhust, When: Date / Time"),
                            Text("Prev, Submit"),
                          ],
                        )),
                    TabInfo(
                        tabLabel: Tab(text: "Confirmed"),
                        child: Column(
                          children: [
                            Text("For: User, In: Bathurst, At: Date / Time"),
                            Text("Back"),
                          ],
                        )),
                  ],
                )),
            TabInfo(
              tabLabel: Tab(text: "Calendar"),
              child: Calendar(),
            ),
          ],
        ),
      ),
    );
  }
}
