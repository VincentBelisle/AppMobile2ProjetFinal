import 'package:flutter/material.dart';
import 'package:projet_final/src/data/dataSource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import '../../data/entities/activity_entity.dart';
import '../../data/services/activity_services.dart';

// create a calendar widget
class CalendrierJour extends StatefulWidget {
  final dbHelper = ActivityService();

  // List of activities to display
  List<ActivityEntity> activities = [];

  @override
  _CalendrierJourState createState() => _CalendrierJourState();
}

class _CalendrierJourState extends State<CalendrierJour> {
  @override
  void initState() {
    // get the list of activities
    getActivities();

    super.initState();
  }

  getActivities() async {
    List<ActivityEntity> activities = await widget.dbHelper.activities();
    setState(() {
      widget.activities = activities;
    });

    return activities;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('fr'),
      ],
      locale: const Locale('fr'),
      home: Scaffold(
          body: SfCalendar(
        view: CalendarView.week,
        timeSlotViewSettings: const TimeSlotViewSettings(numberOfDaysInView: 3),
        dataSource: MeetingDataSource(getDataSource(widget.activities)),
      )),
    );
  }
}
