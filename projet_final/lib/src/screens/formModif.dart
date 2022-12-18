import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:projet_final/src/data/services/activity_services.dart';


import '../data/entities/activity_entity.dart';

class FormModifier extends StatefulWidget {
  FormModifier(this.activite, {Key? key}) : super(key: key);

  @override
  _FormModifierState createState() => _FormModifierState();

  final ActivityEntity activite;

  final dbHelper = ActivityService();

}

class _FormModifierState extends State<FormModifier> {

   // Nom de l'activité

  String _nom = '';

  String _description = '';
  TextEditingController _dateDebutController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();
  DateTime _dateDebut = DateTime.now();
  DateTime _dateFin = DateTime.now();
  

  @override
  void initState() {
    super.initState();
    _nom = widget.activite.nom;
    _description = widget.activite.description;
    _dateDebutController.text = DateFormat('dd/MM/yyyy HH:mm').format(widget.activite.heureDebut);
    _dateFinController.text = DateFormat('dd/MM/yyyy HH:mm').format(widget.activite.heureFin);
  }

  
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();


  

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

      initialValue: _nom,
      decoration: const InputDecoration(
          labelText: 'Nom activité', hintText: 'Nom de l\'activité'),
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
      initialValue: _description,
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
      controller: _dateDebutController,
      decoration: const InputDecoration(
          labelText: 'Heure de début', hintText: 'Date de l\'activité'),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2022, 12, 31), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.fr);

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

              // Datetime format
          String formattedDate = DateFormat('yyyy-MM-dd').add_jm().format(pickedDate);


          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _dateDebutController.text = formattedDate;
            _dateDebut = pickedDate;

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
          _dateDebutController.text = value.toString();
        });
      },
    ));

    // Add a date picker
    formWidget.add(TextFormField(
      controller: _dateFinController,
      decoration: const InputDecoration(
          labelText: 'Heure de fin', hintText: 'Date de l\'activité'),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: _dateDebut,
            maxTime: DateTime(2023, 12, 31), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.fr);

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

          String formattedDate = DateFormat('yyyy-MM-dd').add_jm().format(pickedDate);

          _dateFin = pickedDate;
         //formatted date output using intl package =>  2021-03-16
          setState(() {
            _dateFinController.text = formattedDate;
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
          _dateFinController.text = value.toString();
        });
      },
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        ActivityEntity activity = ActivityEntity(
            widget.activite.id,
            _nom,
            _description,
            _dateDebut,
            _dateFin,
            );

        widget.dbHelper.updateActivity(activity);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Activité modifiée')));

        // Animation de retour
        
        // pop the page
        Navigator.pop(context);
      }
      

    }formWidget.add(ElevatedButton(
        child: const Text('Modifier l\'activité'), onPressed: onPressedSubmit));

    

    return formWidget;
  }
}
