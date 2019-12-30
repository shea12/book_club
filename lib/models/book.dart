class Book {
  final int id;
  final String title;
  final String author;
  final DateTime dateChosen;
  final String mediaType; // TODO: make an enum of possible media types
  Book(this.id, this.title, this.author, this.dateChosen, this.mediaType);
}
