class ActivityEntity {
  // optional id
  final int id;
  final String nom;
  final String description;
  final DateTime heureDebut;
  final DateTime heureFin;

  ActivityEntity(
    this.id,
    this.nom,
    this.description,
    this.heureDebut,
    this.heureFin,
  );


  static ActivityEntity FromMap(Map<String, dynamic> map) {
    var entity = ActivityEntity(map['id'], map['nom'],map['description'], DateTime.parse(map['heureDebut']), DateTime.parse(map['heureFin']));

    return entity;
  }


  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'description': description,
      'heureDebut': heureDebut.toString(),
      'heureFin': heureFin.toString(),
    };
  }

  @override
  String toString() {
    return 'ScoreActivity{id: $id, nom:$nom, description: $description, heureDebut: $heureDebut, heureFin: $heureFin}';
  }
}
