class Meeting {
  final int id;
  final int bookId;
  final String notes;
  final String location;
  final DateTime dateHeld;
  final DateTime dateChosen;
  Meeting(this.id, this.bookId, this.notes, this.location, this.dateHeld,
      this.dateChosen);
}
