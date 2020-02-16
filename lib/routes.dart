import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/tabwrapper.dart';
import 'package:flutter/widgets.dart';
import 'package:book_club/screens/club/new_club.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => TabWrapper(),
  "/new_club": (BuildContext context) => NewClub()
};