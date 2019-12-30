import 'package:flutter/widgets.dart';
import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/club/clubscreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => Home(),
  "/club": (BuildContext context) => ClubScreen(),
};