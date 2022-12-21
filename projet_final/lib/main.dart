import 'package:flutter/material.dart';
import 'package:projet_final/src/components/calendrier/calendrier.dart';
import 'package:projet_final/src/components/calendrier/calendrierJour.dart';
import 'package:projet_final/src/data/entities/activity_entity.dart';
import 'package:projet_final/src/data/services/activity_services.dart';
import 'package:projet_final/src/screens/formAjout.dart';
import 'package:projet_final/src/screens/listeActivite.dart';


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

 

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

   // List of activities to display
  List<ActivityEntity> activities = [];

  final dbHelper = ActivityService();

  // this method will be called when the widget is created
  @override
  void initState() {
    getActivities();
    super.initState();
  }

  getActivities() async {
    List<ActivityEntity> activities = await dbHelper.activities();
    setState(() {
      this.activities = activities;
      print(activities);
    });


    return activities;
   
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

  final List<Widget> widgetOptions = <Widget>[    CalendrierJour(),    Calendrier(),    ListeActivite(activities: activities)  ];
    
    return 
    Scaffold(
      appBar: AppBar(
        // Set the AppBar title using the label of navbar item.
        title: const Text("Agenda"),
        // add a button to add an activity
        actions: <Widget>[
          // si sur la page de la liste des activités, on affiche pas le bouton
          if (_selectedIndex == 2)
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Ajouter un activité',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AjoutActivite()
                    // add the activitiy to the list
                    ),
              ).then(
                // ajouter l'activité à la liste
                (value) => setState(() {
                  activities.add(value);
                }),
              );     
            },
          ),
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
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
            icon: Icon(Icons.check_box),
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

  AjoutActivite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout activité'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: FormAjout(),
      ),
    );
  }
}

