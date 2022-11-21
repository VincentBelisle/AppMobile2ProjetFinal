import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


// create a calendar widget
class Calendrier extends StatefulWidget {
  @override
  _CalendrierState createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  @override
Widget build(BuildContext context) {
  return MaterialApp(
                localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        SfGlobalLocalizations.delegate
                ],
                supportedLocales: [
                        const Locale('fr'),
                ],
                locale: const Locale('fr'),
                home: Scaffold(
                    body: SfCalendar(
                    view: CalendarView.month,
                    monthViewSettings: MonthViewSettings(showAgenda: true),

                ),
         ),
     );
}
}
