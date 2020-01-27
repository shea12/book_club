class User {
  final String uid;
  String email;
  String name;
  DateTime dateCreated;
  DateTime dateUpdated;
  List<String> clubIds;
  String documentID;

  User({
    this.uid,
    this.email,
    this.name,
    this.dateCreated,
    this.dateUpdated,
    this.clubIds,
    this.documentID,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'dateCreated': dateCreated,
        'dateUpdated': dateUpdated,
        'clubIds': clubIds,
        'docRef': documentID,
      };
}
