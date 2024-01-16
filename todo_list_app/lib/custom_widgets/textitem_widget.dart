import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextItem extends StatelessWidget{
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const TextItem({
    super.key, 
    required this.text, 
    required this.fontSize, 
    required this.fontWeight, 
    required this.color
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text, 
        style: GoogleFonts.getFont(
          'Quicksand', 
          fontWeight: fontWeight, 
          color: color, 
          fontSize: fontSize
        )
      ),
    );
  }
}