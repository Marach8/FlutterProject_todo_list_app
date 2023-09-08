import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarAlert {
  final BuildContext context;  

  SnackBarAlert({required this.context,});

  void snackBarAlert(String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Ok', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(), textColor: Colors.blue,
        ),
        content: Text(
          text,
          style: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w500, fontSize: 20, color: Colors.red.shade500),
        ),
        backgroundColor: Colors.white, duration: const Duration(seconds: 2), elevation: 20,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
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
        leading: Icon(icon, size: 40, color: Colors.blue,), elevation: 5,
        actions: [
          TextButton(
            onPressed:(){ScaffoldMessenger.of(context).hideCurrentMaterialBanner();}, 
            child: const Text(
              'Ok', style: TextStyle(fontFamily: 'monospace', fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blue)
            )
          )
        ],
        backgroundColor: Colors.white, shadowColor: Colors.yellow, padding: const EdgeInsets.all(10),
        content: Text(
          text, 
          style: const TextStyle(
            fontFamily: 'monospace', fontSize: 15,
            fontWeight: FontWeight.bold, color: Colors.black
          )
        ),
      )
    );
  }
}

// void notify1(String text, IconData icon){
//       ScaffoldMessenger.of(context).showMaterialBanner(
//         MaterialBanner(
//           leading: Icon(icon, size: 40, color: Colors.blue,), elevation: 5,
//           actions: [
//             TextButton(
//               onPressed:(){ScaffoldMessenger.of(context).hideCurrentMaterialBanner();}, 
//               child: const Text(
//                 'Ok', style: TextStyle(fontFamily: 'monospace', fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blue)
//               )
//             )
//           ],
//           backgroundColor: Colors.white, shadowColor: Colors.yellow, padding: const EdgeInsets.all(10),
//           content: Text(
//             text, 
//             style: const TextStyle(
//               fontFamily: 'monospace', fontSize: 15,
//               fontWeight: FontWeight.bold, color: Colors.black
//             )
//           ),
//         )
//       );
//     }