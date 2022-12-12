import 'package:flutter/material.dart';

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
            child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 30, right: 30),
                      //master text and some tex
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 250,
                                        child: FutureBuilder(
                                            future: widget.dbHelper.activities(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                widget.activities = snapshot.data!;

                                                return ListView.separated(
                                                  itemCount:
                                                      widget.activities.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Dismissible(
                                                      key: Key(UniqueKey()
                                                          .toString()),
                                                      direction:
                                                          DismissDirection
                                                              .endToStart,
                                                      onDismissed: (direction) {
                                                        setState(() {
                                                          widget.dbHelper
                                                              .deleteActivity(
                                                                  widget
                                                                      .activities[
                                                                          index]
                                                                      .id);
                                                          widget.activities
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      background: Container(
                                                        color: Colors.red,
                                                        child: const Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
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
                                                              widget.activities[
                                                                      index]
                                                                  .nom),
                                                          subtitle: Text(
                                                              widget.activities[
                                                                      index]
                                                                  .description),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return const Divider();
                                                  },
                                                );
                                              } else {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
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
                      
                

