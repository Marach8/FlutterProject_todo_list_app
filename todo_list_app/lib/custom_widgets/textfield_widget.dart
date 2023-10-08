import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodoTextFields{
  Widget addTodoTextFields(String text, TextEditingController control, Function(String)? onChanged){
    return Container(
      padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius:10, spreadRadius: 10)]
      ),
      child: SingleChildScrollView(
        child: TextField( 
          onChanged: onChanged,
          controller: control,
          maxLines: null, autocorrect: true, 
          cursorColor: Colors.blue,              
          decoration: InputDecoration(
            border: InputBorder.none, focusedBorder: InputBorder.none,
            fillColor: Colors.black, filled: true,
            hintText: text,
            hintStyle: TextStyle(
              fontFamily: 'monospace', color: Colors.blueGrey.withOpacity(0.9),
              fontSize: 20, fontWeight: FontWeight.bold,
            )
          ),
          style: const TextStyle(
            fontSize: 20, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'monospace'
          )
        ),
      ),
    );
  }
}

class LoginAndSignUpTextFields{
  Widget loginAndSignUpTextField(
      bool enabled, Color color, String hintText, TextEditingController controller, bool obscureText, Widget? suffixIcon
    ){
    return  Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), 
      decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(blurRadius:3, spreadRadius: 1, color: Colors.black)],                            
      ),
      child: SingleChildScrollView(
        child: TextField(
          controller: controller, enabled: enabled, obscureText: obscureText,
          autocorrect: true, cursorColor: Colors.black,
          style: GoogleFonts.getFont('Quicksand', color: Colors.blueGrey.shade900, fontWeight: FontWeight.w500,), 
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: InputBorder.none, hintText: hintText,
            hintStyle: GoogleFonts.getFont('Nunito', color: Colors.black45, fontWeight: FontWeight.w500,),
          ),
        ),
      ),
    );
  }
}