import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_final/src/components/calendrier/calendrier.dart';
import 'package:projet_final/src/components/calendrier/calendrierJour.dart';
import 'package:projet_final/src/data/entities/activity_entity.dart';
import 'package:projet_final/src/data/services/activity_services.dart';
import 'package:projet_final/src/screens/formAjout.dart';
import 'package:projet_final/src/screens/listeActivite.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({super.key});

  // List of activities to display

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  List<ActivityEntity> activities = [];

  // this method will be called when the widget is created
  @override
  void initState() {

    super.initState();
  }

  

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // create a calendar widget
  final List<Widget> _widgetOptions = <Widget>[
    
    CalendrierJour(),
    Calendrier(),
    HighscoreScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        // Set the AppBar title using the label of navbar item.
        title: const Text("Agenda"),
        // add a button to add an activity
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Ajouter un activité',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AjoutActivite(activities)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            // add todo icon
            icon: Icon(Icons.location_on),
            label: 'À faire',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AjoutActivite extends StatelessWidget {
  // List of activities to display
  List<ActivityEntity> activities = [];

  AjoutActivite(List activities, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout activité'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: FormAjout(activities),
      ),
    );
  }
}

