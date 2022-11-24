import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


// create a calendar widget
class CalendrierJour extends StatefulWidget {
  @override
  _CalendrierJourState createState() => _CalendrierJourState();
}

class _CalendrierJourState extends State<CalendrierJour> {
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
      )
         ),
     );
}
}
