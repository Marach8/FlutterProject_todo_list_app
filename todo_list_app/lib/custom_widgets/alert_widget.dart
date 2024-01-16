import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarAlert {
  final BuildContext context;  
  SnackBarAlert({required this.context,});

  void snackBarAlert(String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Ok', onPressed: () => 
            ScaffoldMessenger.of(context).hideCurrentSnackBar(), 
          textColor: Colors.blue,
        ),
        content: Text(
          text,
          style: GoogleFonts.getFont(
            'Nunito', 
            fontWeight: FontWeight.w500, 
            fontSize: 20, 
            color: Colors.red.shade500
          ),
        ),
        backgroundColor: Colors.white, 
        duration: const Duration(seconds: 2), 
        elevation: 20,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20)
          )
        ),
      )
    );
  }
}



class MaterialBannerAlert{
  final BuildContext context;

  MaterialBannerAlert({required this.context});

  void materialBannerAlert(String text, IconData icon){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: Icon(icon, size: 40, color: Colors.blue,), 
        elevation: 5,
        actions: [
          TextButton(
            onPressed:(){
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            }, 
            child: const Text(
              'Ok', 
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 20, 
                fontWeight: FontWeight.w300, 
                color: Colors.blue
              )
            )
          )
        ],
        backgroundColor: Colors.white, 
        shadowColor: Colors.yellow, 
        padding: const EdgeInsets.all(10),
        content: Text(
          text, 
          style: const TextStyle(
            fontFamily: 'monospace', fontSize: 15,
            fontWeight: FontWeight.bold, 
            color: Colors.black
          )
        ),
      )
    );
  }
}



class DialogBox{
  final BuildContext context;

  DialogBox({required this. context});

  Future <void> dialogBox(
    TextEditingController control1, 
    TextEditingController control2,
    TextEditingController control3,
  ){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text(
            'Save Todo.', 
            style: GoogleFonts.getFont(
              'Nunito', 
              color: Colors.white,
              fontSize: 25, 
              fontWeight: FontWeight.w500,
            )
          ),
          content: Text(
            'You todo has been saved sucessfully. Do you want to add another?',
            style: GoogleFonts.getFont(
              'Nunito', 
              color: Colors.white, 
              fontSize: 15, 
              fontWeight: FontWeight.w300,
            )
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(); 
                control1.clear(); 
                control2.clear();
                control3.clear();
              }, 
              child: Text(
                'Yes', 
                style: GoogleFonts.getFont(
                  'Nunito',
                  color: Colors.blue, 
                  fontSize: 15, 
                  fontWeight: FontWeight.w400,
                )
              )
            ),
            TextButton(
              onPressed: () {
                control1.clear(); 
                control2.clear(); 
                control3.clear(); 
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              }, 
              child: Text(
                'No', 
                style: GoogleFonts.getFont(
                  'Nunito', 
                  color: Colors.blue, 
                  fontSize: 15, 
                  fontWeight: 
                  FontWeight.w400,
                )
              )
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        );
      }      
    );
  }
}



class ProgressIndicatorDialog{
  alert(BuildContext context, String text){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const LinearProgressIndicator(color: Colors.green),
        title: Text(
          text,
          style: GoogleFonts.getFont('Nunito',fontSize: 25)
        ),
      )
    );
  }
}


class MaterialBannerAlert1{
  final BuildContext context;
  MaterialBannerAlert1(this.context);
  
  materialBannerAlert1(String text, Color color, IconData icon) async{
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: Icon(icon, color: color, size:40), 
        backgroundColor: Colors.blueGrey.shade800,
        content: Text(
          text, 
          style: GoogleFonts.getFont(
            'Nunito', 
            fontSize: 17, 
            fontWeight: FontWeight.w400, 
            color: Colors.white
          )
        ), 
        actions: [
          TextButton(onPressed: 
            () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(), 
          child: Text('Ok', style: GoogleFonts.getFont('Nunito', color: color))
          )
        ]
      )
    );
    await Future.delayed(const Duration(seconds: 5), 
      () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
    );
  }
}
