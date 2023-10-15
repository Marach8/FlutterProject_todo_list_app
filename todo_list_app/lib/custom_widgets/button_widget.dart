import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButtons{
  Widget homeButton(IconData icon, String text, VoidCallback function){
    return TextButton.icon(
      style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.blueGrey.shade100)),
      onPressed: function, icon: Icon(icon),
      label: Text(text, style: GoogleFonts.getFont('Nunito', fontSize: 17, fontWeight: FontWeight.w600,))
    );
  }
}