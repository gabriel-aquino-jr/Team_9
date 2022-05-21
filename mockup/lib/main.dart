import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';
import 'package:mockup/components/tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
