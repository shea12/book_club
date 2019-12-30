import 'package:book_club/models/user.dart';
import 'package:book_club/models/club.dart';
import 'package:book_club/models/meeting.dart';
import 'package:book_club/models/book.dart';

  
// User newUser = User(1, 'emailAddress', 'first', 'last');
class AppState {
  final User user;
  final Club club;
  final Meeting currentMeeting;
  final Book currentBook;
  final List<Meeting> meetingList;
  final List<Book> bookList;

  AppState(this.user, this.club, this.currentMeeting, this.currentBook,
      this.meetingList, this.bookList);

  factory AppState.initial() => AppState(null, null, null, null, null, null);
}
