import 'package:flutter/material.dart';



class CardActivite extends StatefulWidget {
  CardActivite({super.key, required this.nom, required this.description, required DateTime date});

  String nom;
  String description;

  @override
  _CardActiviteState createState() => _CardActiviteState();

}

class _CardActiviteState extends State<CardActivite> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           ListTile(
            title: Text(widget.nom),
            subtitle: Text(widget.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('MODIFIER'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('SUPPRIMER'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}



  