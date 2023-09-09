import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextItem{

  Widget textItem(textItem, double fontSize, FontWeight font, Color color,){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(textItem, style: GoogleFonts.getFont('Quicksand', fontWeight: font, color: color, fontSize: fontSize)),
    );
  }

}