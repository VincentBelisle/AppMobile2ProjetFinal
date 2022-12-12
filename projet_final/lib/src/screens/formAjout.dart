import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_final/src/data/services/activity_services.dart';

import '../data/entities/activity_entity.dart';


class FormAjout extends StatefulWidget {

  FormAjout(List activities, {Key? key}) : super(key: key
  );

  @override
  _FormAjoutState createState() => _FormAjoutState();

  final dbHelper = ActivityService();

  // List of activities to display
  List<ActivityEntity> activities = [];

}



class _FormAjoutState extends State<FormAjout> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _nom = '';
  String _description = '';
  TextEditingController _dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Nom activité', hintText: 'Nom de l\'activité'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer un nom';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _nom = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Description', hintText: 'Description'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer une description';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _description = value.toString();
        });
      },
    ));

    // Add a date picker
    formWidget.add(TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
          labelText: 'Date', hintText: 'Date de l\'activité'),
          readOnly: true,
          onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    _dateController.text = formattedDate;
                  });
                } else {}
              },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer une date';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _dateController.text = value.toString();
        });
      },
       
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        
        ActivityEntity activity = 
        ActivityEntity(0, _nom, _description, DateTime.parse(_dateController.text));

        widget.activities.add(activity);
              



        widget.dbHelper.insertActivity(activity);

        


        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Activité ajoutée')));
        // pop the page
        Navigator.pop(context);
      }
    }

    formWidget.add(ElevatedButton(
        child: const Text('Ajouter l\'activité'), onPressed: onPressedSubmit));

    return formWidget;
  }
}
