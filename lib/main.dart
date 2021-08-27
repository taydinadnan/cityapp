import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: Allcities(),
  ));
}

class Allcities extends StatelessWidget {
  const Allcities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'All Cities',
        ),
      ),
    );
  }
}
