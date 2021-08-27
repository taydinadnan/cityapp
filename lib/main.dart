import 'package:cities_app/Screens/city_screen.dart';
import 'package:flutter/material.dart';

import './Screens/Allcities_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new Allcities(),
    routes: {City.routeName: (ctx) => City()},
  ));
}
