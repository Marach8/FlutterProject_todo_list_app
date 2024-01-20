import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class AddTodoTextFields extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const AddTodoTextFields({
    required this.title,
    required this.controller,
    this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField( 
      onChanged: onChanged,
      controller: controller,
      maxLines: null, 
      autocorrect: true, 
      cursorColor: blueColor,              
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: whiteColor,
          fontSize: fontSize2,
          fontWeight: fontWeight3
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: deepGreenColor
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: deepGreenColor
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(title),
      ),
      style: const TextStyle(
        fontSize: fontSize3,
        decoration: TextDecoration.none
      ), 
    );
  }
}



class LoginAndSignUpTextFields extends StatelessWidget{
  final String? textItem, hintText;
  final bool enabled;
  final bool? showSuffixIcon; 
  final Color color;
  final TextEditingController controller;

  const LoginAndSignUpTextFields({
    this.showSuffixIcon,
    this.textItem,
    this.hintText,
    required this.enabled, 
    required this.color,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext _) {
    return Column(

      children: [
        textItem == null ? const SizedBox.shrink() 
        : TextItem(
          text: textItem ?? '', 
          fontSize: fontSize2, 
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
                color: blackColor
              )
            ],                            
          ),
          child: Consumer<AppUsers>(
            builder: (_, user, __) => TextField(
              controller: controller, 
              enabled: enabled, 
              obscureText: showSuffixIcon == null ? false : user.obscureText,
              cursorColor: blackColor,
              style: GoogleFonts.getFont(
                'Quicksand', 
                color: deepGreenColor,
                fontWeight: fontWeight1,
              ), 
              decoration: InputDecoration(
                suffixIcon: showSuffixIcon != null && 
                  showSuffixIcon == true ? IconButton(
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
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: blackColor, 
                  fontSize: fontSize2,
                )
              ),
            ),
          ),
        ),
        const Gap(10)
      ],
    );
  }
}