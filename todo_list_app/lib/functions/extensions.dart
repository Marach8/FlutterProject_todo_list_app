import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension DecorateText on Text{
  Text decorate(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => Text(data ?? '', 
      style: TextStyle(
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    ),
    overflow: TextOverflow.ellipsis,
  );
}


extension DecorateTextSpan on TextSpan{
  TextSpan decorate(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => TextSpan(
    text: text,
    style: TextStyle(
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    )
  );
}


extension DecorateTextWithGoogleFont on Text{
  Text decoratewithGoogleFont(
    Color color, 
    double fontSize, 
    FontWeight fontWeight,
  ) => Text(data ?? '', 
      maxLines: maxLines,
      style: GoogleFonts.getFont(
      'Quicksand',
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    ),
    overflow: TextOverflow.ellipsis,
  );
}