// import 'package:flutter/material.dart';
// import 'package:mockup/components/tabs.dart';

// // Used Provided. I had originally used this in tabs, but it it wasn't necesary. It could be usefull to pass data to children later.

// class TabProvider extends InheritedWidget {
//   final List<TabInfo> inheritedTabInfoList;
//   final Widget child;

//   TabProvider({required this.child, required this.inheritedTabInfoList})
//       : super(child: child);

//   @override
//   bool updateShouldNotify(TabProvider oldWidget) =>
//       TabInfo != oldWidget.inheritedTabInfoList;

//   static TabProvider of(BuildContext context) {
//     final TabProvider? result =
//         context.dependOnInheritedWidgetOfExactType<TabProvider>();
//     assert(result != null, "No TabProvider found in context");
//     return result!;
//   }
// }
