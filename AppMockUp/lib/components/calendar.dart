import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mockup/utilities/palette.dart';
import 'package:table_calendar/table_calendar.dart';

//#region Utilities
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

// Set initial dates
final calToday = DateTime.now();
final calFirstDay = DateTime(calToday.year, calToday.month - 2, calToday.day);
final calLastDay = DateTime(calToday.year, calToday.month + 5, calToday.day);

final calEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_calEventSource);

final _calEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(calFirstDay.year, calFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    calToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });
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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
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
          //iniat display range
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
          child: const Text('Clear selection'),
          onPressed: () {
            setState(() {
              _selectedDay = calToday;
              // _selectedEvents.value = [];
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
