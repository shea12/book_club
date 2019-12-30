import 'package:flutter/widgets.dart';
import 'package:book_club/screens/home/homescreen.dart';
import 'package:book_club/screens/club/clubscreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/club": (BuildContext context) => ClubScreen(),
};