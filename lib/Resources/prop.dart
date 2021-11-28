import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prop {
  Theme customTheme = Theme(
    data: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF424242),
        primaryVariant: const Color(0xFFB2EBF2),
        secondary: const Color(0xFFFFFFFF), 
      ),
      hintColor: const Color(0xFF424242)
    ),
    child: const TextField(
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Color(0xFF424242)),
      ),
    ),
  );
}
