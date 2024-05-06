
import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration textFormFieldDecoration( String hintText ){
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15  ),
      ),
      hintText: hintText
    );
  }

}