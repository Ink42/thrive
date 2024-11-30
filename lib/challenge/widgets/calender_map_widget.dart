import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderMapWidget extends StatefulWidget {
  CalenderMapWidget({super.key});

  @override
  State<CalenderMapWidget> createState() => _CalenderMapWidgetState();
}

class _CalenderMapWidgetState extends State<CalenderMapWidget> {
  DateTime today = DateTime.now();
  late DateTime _selected ;

  _selectedDay(DateTime day, DateTime focusedDay){
setState(() {
  today = day;
});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            focusedDay: today, 
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false),
              selectedDayPredicate: (day)=>isSameDay(day,today),
              availableGestures: AvailableGestures.all,
            firstDay: DateTime.utc(2024,10,16) , 
            lastDay: DateTime.utc(2030,3,14),
            onDaySelected:_selectedDay ,
            ),
        )
      ],
    );
  }
}