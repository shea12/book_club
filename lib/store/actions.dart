import 'package:book_club/models/club.dart';
import 'package:book_club/models/meeting.dart';
import 'package:book_club/models/book.dart';

// CLUB
class SetClubAction {
  final Club club;
  SetClubAction(this.club);
}

// MEETING
class SetCurrentMeetingAction {
  final Meeting meeting;
  SetCurrentMeetingAction(this.meeting);
}

class SetMeetingListAction {
  final List<Meeting> meetingList;
  SetMeetingListAction(this.meetingList);
}

// BOOK
class SetCurrentBookAction {
  final Book book;
  SetCurrentBookAction(this.book);
}

class SetBookListAction {
  final List<Book> bookList;
  SetBookListAction(this.bookList);
}
