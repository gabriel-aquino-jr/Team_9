import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mockup/components/selection_box.dart';
import 'package:mockup/database/db_helper.dart';
import 'package:mockup/main.dart';
import 'package:mockup/model/global.dart';
import 'package:mockup/model/schedule_model.dart';
import 'package:mockup/utilities/palette.dart';
import 'package:table_calendar/table_calendar.dart';

//#region Utilitie  s
class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

// Connect to database
final dbhelper = DBHelper.instance;

// Set initial dates
// final calToday = DateTime.now();
// final calFirstDay = DateTime(calToday.year, calToday.month - 2, calToday.day);
// final calLastDay = DateTime(calToday.year, calToday.month + 5, calToday.day);

// final calEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_calEventSource);

// final _calEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(calFirstDay.year, calFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     calToday: [
//       const Event('Today\'s Event 1'),
//       const Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
// #endregion

//Region Widget
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key); // Events
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // Update events
  late final ValueNotifier<List<Event>> _selectedEvents;

  // Sets Calendar Fromatt to Month only
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Select day functions
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

// Connect to database
  final dbhelper = DBHelper.instance;

// Set initial dates
  final calToday = DateTime.now();
  late final calFirstDay =
      DateTime(calToday.year, calToday.month - 2, calToday.day);
  late final calLastDay =
      DateTime(calToday.year, calToday.month + 5, calToday.day);

// Query Events
  // late final calEvents = LinkedHashMap<DateTime, List<Event>>(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(_calEventSource);

// Step 3:
  Map<DateTime, List<Event>> calEvents = {};

// Step 1: Get Data from database
  List<Schedules> _schedules = [];
  void _queryAllEvents() async {
    dbhelper.database;
    final allRows = await dbhelper.queryDatesAvailable(
        AppointmentInfo.type, AppointmentInfo.city);
    debugPrint('query all employee rows:');
    for (var row in allRows) {
      _schedules.add(Schedules.fromMap(row));
    }
    _toCalenderEvents();

    calEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_calEventSource);

    setState(() {});
    allRows.forEach(print);
  }

//  Step 2: Format to Calendar Type
  Map<DateTime, List<Event>> _calEventSource = {};
  void _toCalenderEvents() {
    for (var s in _schedules) {
      List<Event> events = [Event("${s.type} - ${s.location}")];
      _calEventSource[s.dateTime!] = events;
    }
  }

  @override
  void initState() {
    super.initState();
    (AppointmentInfo.date == "")
        ? _selectedDay = _focusedDay
        : _selectedDay = DateTime.parse(AppointmentInfo.date);
    _queryAllEvents();
    print("CalEvents: " + calEvents.entries.toString());
    //Selects events for today
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  List<Event> _getEventsForDay(DateTime day) {
    return calEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          //initial display range
          firstDay: calFirstDay,
          lastDay: calLastDay,
          focusedDay: calToday,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: const CalendarStyle(
            rangeHighlightColor: Palette.medGreen,
            todayDecoration: BoxDecoration(color: Palette.lightGreen),
            selectedDecoration: BoxDecoration(color: Palette.darkGreen),
          ),
          calendarFormat: _calendarFormat,

          eventLoader: _getEventsForDay,

          // Methods
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
                AppointmentInfo.date = _selectedDay.toString().substring(0, 10);
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
        ElevatedButton(
          child: const Text('Go To Today'),
          onPressed: () {
            setState(() {
              _selectedDay = calToday;
              print("CalEvents " + calEvents.toString());
            });
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
