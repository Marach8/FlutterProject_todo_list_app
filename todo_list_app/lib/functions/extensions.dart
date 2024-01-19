import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension DecorateText on Text{
  Flexible decorate(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => Flexible(
    child: Text(data ?? '', 
        style: TextStyle(
        color: color, 
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
      overflow: TextOverflow.ellipsis,
    ),
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
  Flexible decoratewithGoogleFont(
    Color color, 
    double fontSize, 
    FontWeight fontWeight
  ) => Flexible(
    child: Text(data ?? '', 
        style: GoogleFonts.getFont(
        'Nunito',
        color: color, 
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}