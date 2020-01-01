import 'package:meta/meta.dart';

class User {
  final String uid;
  final String name;
  final String email;

  User({
    @required this.uid,
    @required this.name,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'updated': DateTime.now(),
      };
}

class Club {
  final String name;
  final String secret;

  Club({
    @required this.name,
    @required this.secret,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'secret': secret,
        'created': DateTime.now(),
      };
}

class Meeting {
  final String name;
  final DateTime chosen;
  final DateTime held;
  String location;
  String bookId;

  Meeting({
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

class Book {
  final String googleId;
  final String title;
  final String author;
  final String media;

  Book({
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
