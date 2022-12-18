import 'package:flutter/material.dart';
import 'package:projet_final/src/screens/formModif.dart';

import '../data/entities/activity_entity.dart';
import '../data/services/activity_services.dart';

/// Displays the various settings that can be customized by the user.
///
class HighscoreScreen extends StatefulWidget {
  HighscoreScreen({super.key});

  final dbHelper = ActivityService();

  List<ActivityEntity> activities = [];

  @override
  _HighscoreScreenState createState() => _HighscoreScreenState();
}

class _HighscoreScreenState extends State<HighscoreScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      'Activités',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 400,
                          child: FutureBuilder(
                              future: widget.dbHelper.activities(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  widget.activities = snapshot.data!;

                                  return ListView.separated(
                                    itemCount: widget.activities.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Dismissible(
                                        key: Key(UniqueKey().toString()),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          setState(() {
                                            widget.dbHelper.deleteActivity(
                                                widget.activities[index].id);
                                            widget.activities.removeAt(index);
                                          });
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Card(
                                          child: ListTile(
                                            title: Text(
                                              // afficher la date sans les millisecondes
                                              "${widget.activities[index].heureDebut.toString().substring(0, 16)} - ${widget.activities[index].nom}",

                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            subtitle: Text(widget
                                                .activities[index].description
                                                .toString()),

                                            // Ajouter un crayon pour modifier l'activité
                                            trailing: IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModifierActivite(
                                                              widget.activities[
                                                                  index]),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider();
                                    },
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }
}

class ModifierActivite extends StatelessWidget {
  final ActivityEntity activity;

  const ModifierActivite(this.activity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier activité'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: FormModifier(activity),
      ),
    );
  }
}
