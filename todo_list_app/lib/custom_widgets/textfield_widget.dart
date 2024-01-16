import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

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



class LoginAndSignUpTextFields extends StatelessWidget{
  final String? textItem;
  final bool enabled;
  final bool? showSuffixIcon; 
  final Color color;
  final TextEditingController controller;

  const LoginAndSignUpTextFields({
    this.showSuffixIcon,
    this.textItem,
    required this.enabled, 
    required this.color,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext _) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textItem == null ? const SizedBox.shrink() 
        : TextItem(
          text: textItem ?? '', 
          fontSize: fontSize1, 
          fontWeight: fontWeight1,
          color: blackColor
        ),
        
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), 
          decoration: BoxDecoration(
            color: color, 
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3, 
                spreadRadius: 1, 
                color: Colors.black
              )
            ],                            
          ),
          child: Consumer<AppUsers>(
            builder: (_, user, __) => TextField(
              controller: controller, 
              enabled: enabled, 
              obscureText: user.obscureText,
              cursorColor: blackColor,
              style: GoogleFonts.getFont(
                'Quicksand', 
                color: deepGreenColor,
                fontWeight: fontWeight1,
              ), 
              decoration: InputDecoration(
                suffixIcon: showSuffixIcon != null && 
                  showSuffixIcon == true ? IconButton(
                    //Will remove setState later and use a stateless wiget
                    onPressed: () => user.callToAction(
                      () => user.obscureText = !user.obscureText),
                    icon: Icon(
                      user.obscureText 
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded, 
                      color: deepGreenColor
                    )
                  ): const SizedBox.shrink(),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const Gap(10)
      ],
    );
  }
}