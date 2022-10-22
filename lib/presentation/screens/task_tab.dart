import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_tasks/data/firebase-utils.dart';

import '../../data/to_do.dart';
import '../widgets/task_widget.dart';

class TaskTap extends StatefulWidget {
  @override
  State<TaskTap> createState() => _TaskTapState();
}

class _TaskTapState extends State<TaskTap> {
  DateTime selectedDay = DateTime.now();
  DateTime foucDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          onDaySelected: (sd, focusedDay) {
            setState(() {
              selectedDay = sd;
              foucDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarFormat: CalendarFormat.week,
          calendarStyle: CalendarStyle(
            selectedTextStyle: TextStyle(color: Colors.white),
            selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            todayTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(10)),
            defaultDecoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          weekendDays: [],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Todo>>(
              stream: getTodoCollectionRefrence().snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Todo>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Todo> item =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskWidget(item[index]);
                  },
                  itemCount: item.length,
                );
              }),
        )
      ],
    );
  }
}
