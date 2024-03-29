import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/constants/strings.dart' show quicksandFont;

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
      quicksandFont,
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight
    ),
    overflow: TextOverflow.ellipsis,
  );
}


extension CheckMapEquality on Map<String, dynamic>{
  bool checkMapEquality(Map<String, dynamic> map){
    bool theyAreEqual = true;
    for(final key in keys){
      if (this[key] != map[key]){
        theyAreEqual = false;
        return theyAreEqual;
      }
    }
    return theyAreEqual;
  }
}