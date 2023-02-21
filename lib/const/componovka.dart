import 'package:flutter/material.dart';

class Componovka {
  static getDetailedDouble(String nazvan, double? value, String units) {
    return Column(
      children: [
        Text(
          '$nazvan',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              '$value',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            Text(
              '$units',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  static getDetailedInt(String nazvan, int value, String units) {
    return Column(
      children: [
        Text(
          '$nazvan',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              '$value',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            Text(
              '$units',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
