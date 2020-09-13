import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var _city = 'Cairo';
  var _cities = ['Cairo', 'Giza', 'Alx', 'Maina', '6 October'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: DropdownButton<String>(
          value: _city,
          items: _cities.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(
              () {
                _city = newValue;
              },
            );
          },
        ),
      ),
    );
  }
}
