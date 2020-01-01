import 'package:redux/redux.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/models/club.dart';
import 'package:book_club/models/meeting.dart';
import 'package:book_club/models/book.dart';
import 'package:book_club/store/actions.dart';

AppState appReducer(AppState state, action) => AppState(
  clubReducer(state.club, action),
);

final Reducer<Club> clubReducer = combineReducers([
  TypedReducer<Club, SetClubAction>(_setClub),
]);
Club _setClub(Club club, SetClubAction action) => action.club;

final Reducer<Meeting> currentMeetingReducer = combineReducers([
  TypedReducer<Meeting, SetCurrentMeetingAction>(_setCurrentMeeting),
]);
Meeting _setCurrentMeeting(Meeting meeting, SetCurrentMeetingAction action) =>
    action.meeting;

final Reducer<Book> currentBookReducer = combineReducers([
  TypedReducer<Book, SetCurrentBookAction>(_setCurrentBook),
]);
Book _setCurrentBook(Book book, SetCurrentBookAction action) => action.book;

final Reducer<List<Meeting>> meetingListReducer = combineReducers([
  TypedReducer<List<Meeting>, SetMeetingListAction>(_setMeetingList),
]);
List<Meeting> _setMeetingList(
        List<Meeting> meetingList, SetMeetingListAction action) =>
    action.meetingList;

final Reducer<List<Book>> bookListReducer = combineReducers([
  TypedReducer<List<Book>, SetBookListAction>(_setBookList),
]);
List<Book> _setBookList(List<Book> bookList, SetBookListAction action) =>
    action.bookList;
