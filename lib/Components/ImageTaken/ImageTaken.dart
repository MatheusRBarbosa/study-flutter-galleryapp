import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galleryapp/Models/Locatedfile.dart';

Widget ImageTaken(Locatedfile locatedfile) {
  return Container(
      child: Row(children: [
    Image.file(
      File(locatedfile.pickedFile.path),
      width: 200,
      height: 200,
    ),
    Padding(
      padding: const EdgeInsets.all(8),
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _label('Latitude: '),
            Text(locatedfile.position.latitude.toString())
          ],
        ),
        Row(
          children: [
            _label('Longitude: '),
            Text(locatedfile.position.longitude.toString())
          ],
        ),
      ],
    ),
  ]));
}

Widget _label(String text) {
  return Text(
    text,
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}
