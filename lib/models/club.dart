class Club {
  final String name;
  final String secret;
  DateTime dateCreated;

  Club({this.name, this.secret, this.dateCreated});

  Map<String, dynamic> toJson() => {'name': name, 'secret': secret};
}
