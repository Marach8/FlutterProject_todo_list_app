import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension DecorateText on Text{
  Text decorate(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => Text(data ?? '', style: TextStyle(
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    ));
}


extension DecorateTextWithGoogleFont on Text{
  Text decoratewithGoogleFont(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => Text(data ?? '', style: GoogleFonts.getFont(
      'Nunito',
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    ));
}