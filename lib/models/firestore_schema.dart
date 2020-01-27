import 'package:meta/meta.dart';

class FireUser {
  final String uid;
  final String name;
  final String email;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final List<String> clubs;

  FireUser({
    @required this.uid,
    @required this.name,
    this.email,
    this.dateCreated,
    this.dateUpdated,
    this.clubs
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'dateCreated': dateCreated,
        'dateUpdated': dateUpdated,
        'clubs': clubs
      };
}

class FireClub {
  final String name;
  final String secret;
  DateTime dateCreated;

  FireClub({
    @required this.name,
    @required this.secret,
    this.dateCreated
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'secret': secret,
        'dateCreated': DateTime.now(),
      };
}

class FireMeeting {
  final String name;
  final DateTime chosen;
  final DateTime held;
  String location;
  String bookId;

  FireMeeting({
    @required this.name,
    @required this.chosen,
    @required this.held,
    @required this.location,
    @required this.bookId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'chosen': DateTime.now(),
        'held': held,
        'location': location,
        'bookId': bookId,
      };
}

class FireBook {
  final String googleId;
  final String title;
  final String author;
  final String media;

  FireBook({
    @required this.googleId,
    @required this.title,
    @required this.author,
    @required this.media,
  });

  Map<String, dynamic> toJson() => {
        'googleId': googleId,
        'title': title,
        'author': author,
        'media': media
      };
}
