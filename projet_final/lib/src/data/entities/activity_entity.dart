class ActivityEntity {
  final int id;
  final String nom;
  final String description;
  late DateTime date;

  ActivityEntity(
    this.id,
    this.nom,
    this.description,
    this.date)
;

  static ActivityEntity FromMap(Map<String, dynamic> map) {
    var entity = ActivityEntity(map['id'], map['nom'],map['description'], DateTime.parse(map['date']));

    return entity;
  }


  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'nom': nom,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'ScoreActivity{id: $id, nom:$nom, description: $description, date: $date}';
  }
}
