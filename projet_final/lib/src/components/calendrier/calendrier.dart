import 'package:flutter/material.dart';
import 'package:projet_final/src/data/entities/activity_entity.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import '../../data/dataSource.dart';
import '../../data/services/activity_services.dart';

// create a calendar widget
class Calendrier extends StatefulWidget {
  final dbHelper = ActivityService();

  // List of activities to display
  List<ActivityEntity> activities = [];

  @override
  _CalendrierState createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
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
        // Fade in / out animation when the list of activities changes
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          child: SfCalendar(
            key: ValueKey(widget.activities),
            view: CalendarView.month,
            monthViewSettings: const MonthViewSettings(showAgenda: true),
            dataSource: MeetingDataSource(getDataSource(widget.activities)),
          ),
        ),
      ),
    );
  }
}
