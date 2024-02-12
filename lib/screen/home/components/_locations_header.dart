import 'package:flutter/material.dart';

Row sectionHeader(title) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )
    ],
  );
}
