import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:projet_final/src/data/entities/activity_entity.dart';




List<Meeting> getDataSource(List<ActivityEntity> activities) {
  late List<Meeting> meetings = <Meeting>[];


  for (var activity in activities) {
    meetings.add(Meeting(activity.nom, activity.description, activity.heureDebut, activity.heureFin, Colors.blue, false));
  }
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.description, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  String description;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
