class Club {
  final String name;
  final String secret;
  DateTime dateCreated;
  final String documentID;

  Club({this.name, this.secret, this.dateCreated, this.documentID});

  Map<String, dynamic> toJson() => {'name': name, 'secret': secret};
}
