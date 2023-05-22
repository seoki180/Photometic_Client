import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void onDaySelected(selectedDate, focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainCalendar(
            onDaySelected: onDaySelected,
            selectedDate: selectedDate,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("hlelo"),
            ),
          ),
        ],
      ),
    );
  }
}

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Column(
              children: [
                Text(day.toString().substring(8, 10)),
              ],
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Column(
              children: [
                Text(
                  day.toString().substring(8, 10),
                  style: const TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ],
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Column(
              children: [
                Text(
                  day.toString().substring(8, 10),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Image.asset("assets/images/img1.gif"),
              ],
            );
          },
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        rowHeight: 100,
        focusedDay: DateTime.now(),
        firstDay: DateTime(1900, 1, 1),
        lastDay: DateTime(2999, 1, 1),
        onDaySelected: onDaySelected,
        selectedDayPredicate: (day) =>
            day.year == selectedDate.year &&
            day.month == selectedDate.month &&
            day.day == selectedDate.day,
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultTextStyle: const TextStyle(),
          rowDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
