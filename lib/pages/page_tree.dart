import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_demo/components/activity_indicator.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/pages/background.dart';
import 'package:flutter_demo/redux/app_state.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redux/redux.dart';

class PageTree extends StatefulWidget {
  final Store<AppState> store;
  const PageTree({Key? key, required this.store}) : super(key: key);

  @override
  State<PageTree> createState() => _PageTreeState();
}

class _PageTreeState extends State<PageTree> {
  bool loading = false;
  bool responseOk = false;

  DateTime selectedDay = DateTime.now();
  List<CleanCalendarEvent> selectedEvent = [];

  final Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
      CleanCalendarEvent('Event D',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.green),
      CleanCalendarEvent('Event E',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.purple),
      CleanCalendarEvent('Event F',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.purple),
      CleanCalendarEvent('Event G',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.purple),
    ],
  };

  @override
  void initState() {
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Calendar(
            todayButtonText: 'Hoy es',
            locale: 'es_ES',
            startOnMonday: true,
            selectedColor: Colors.blue,
            todayColor: Color.fromARGB(255, 250, 250, 250),
            eventColor: Color.fromARGB(255, 243, 0, 0),
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {
              print('selected Day ${range.from},${range.to}');
            },
            onDateSelected: (date) {
              return _handleData(date);
            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: ['Lun', 'Mar', 'Mir', 'Jue', 'Vir', 'Sab', 'Dom'],
          ),
        ),
      ),
    );
  }
}
