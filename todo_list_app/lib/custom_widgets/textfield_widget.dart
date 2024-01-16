import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';

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



class LoginAndSignUpTextFields extends StatefulWidget{
  final bool enabled;
  final bool? showSuffixIcon; 
  final Color color;
  final TextEditingController controller;

  const LoginAndSignUpTextFields({
    this.showSuffixIcon,
    required this.enabled, 
    required this.color,
    required this.controller,
    super.key,
  });

  @override
  State<LoginAndSignUpTextFields> createState() => _LoginAndSignUpTextFieldsState();
}

class _LoginAndSignUpTextFieldsState extends State<LoginAndSignUpTextFields> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), 
      decoration: BoxDecoration(
        color: widget.color, 
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3, 
            spreadRadius: 1, 
            color: Colors.black
          )
        ],                            
      ),
      child: SingleChildScrollView(
        child: TextField(
          controller: widget.controller, 
          enabled: widget.enabled, 
          obscureText: obscureText,
          cursorColor: blackColor,
          style: GoogleFonts.getFont(
            'Quicksand', 
            color: deepGreenColor,
            fontWeight: fontWeight1,
          ), 
          decoration: InputDecoration(
            suffixIcon: widget.showSuffixIcon != null && 
              widget.showSuffixIcon == true ? IconButton(
                //Will remove setState later and use a stateless wiget
                onPressed: () => setState(()=> obscureText = !obscureText),
                icon: Icon(
                  obscureText ? Icons.visibility_off_rounded: Icons.visibility_rounded, 
                  color: deepGreenColor
                )
              ): const SizedBox.shrink(),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}