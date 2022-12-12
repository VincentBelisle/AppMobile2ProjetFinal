import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_final/src/components/calendrier/calendrier.dart';
import 'package:projet_final/src/components/calendrier/calendrierJour.dart';
import 'package:projet_final/src/components/cardActivite.dart';
import 'package:projet_final/src/data/entities/activity_entity.dart';
import 'package:projet_final/src/data/services/activity_services.dart';
import 'package:projet_final/src/screens/formAjout.dart';
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

  final dbHelper = ActivityService();

  // List of activities to display
  List<ActivityEntity> activities = [];

  MyStatefulWidget({super.key});
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // create a calendar widget
  final List<Widget> _widgetOptions = <Widget>[
    CalendrierJour(),
    Calendrier(),
    // Get the list of activities from the database
    FutureBuilder<List<ActivityEntity>>(
      future: ActivityService().activities(),
      builder: (BuildContext context, AsyncSnapshot<List<ActivityEntity>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return CardActivite(nom: snapshot.data![index].nom, description: snapshot.data![index].description, date: snapshot.data![index].date);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
   

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                MaterialPageRoute(builder: (context) => AjoutActivite(widget.activities)
                ),
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
    

