import 'package:flutter/material.dart';

class TextFields{
  Widget textFields(String text, TextEditingController control){
    return Container(
      padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius:10, spreadRadius: 10)]
      ),
      child: SingleChildScrollView(
        child: TextField( 
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


// Widget textFields(String text, TextEditingController control){
//     return Container(
//       padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [BoxShadow(blurRadius:10, spreadRadius: 10)]
//       ),
//       child: SingleChildScrollView(
//         child: TextField( 
//           controller: control,
//           maxLines: null, autocorrect: true, 
//           cursorColor: Colors.blue,              
//           decoration: InputDecoration(
//             border: InputBorder.none, focusedBorder: InputBorder.none,
//             fillColor: Colors.black, filled: true,
//             hintText: text,
//             hintStyle: TextStyle(
//               fontFamily: 'monospace', color: Colors.blueGrey.withOpacity(0.9),
//               fontSize: 20, fontWeight: FontWeight.bold,
//             )
//           ),
//           style: const TextStyle(
//             fontSize: 20, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'monospace'
//           )
//         ),
//       ),
//     );
//   }