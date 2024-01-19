import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen_controller.dart';
import 'package:todo_list_app/functions/extensions.dart';

class LoadingScreen{
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;
  
  LoadingScreenController? controller;

  void showOverlay(BuildContext context, String text){
    if(controller?.updateScreen(text) ?? false){
      return;
    } else{
      controller = _showOverlay(context, text);
    }
  }

  void hideOverlay() {
    controller?.closeScreen();
    controller = null;
  }

  LoadingScreenController? _showOverlay(
    BuildContext context, String text
  ){
    final state = Overlay.of(context);
    if(!state.mounted){
      return null;
    }

    final textStream = StreamController<String>();
    textStream.sink.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    
    final overlay = OverlayEntry(
      builder: (_) => Material(
        color: blackColor.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5
            ),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(10),
                    const CircularProgressIndicator(color: greenColor),
                    const Gap(15),
                    StreamBuilder(
                      stream: textStream.stream,
                      builder: (_, snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data!)
                            .decoratewithGoogleFont(
                              greenColor, fontSize1, fontWeight1
                            );
                        } else{
                          return const SizedBox.shrink();
                        }
                      }
                    )
                  ],
                ),
              ),
            ),
          )
        )
      )
    );
    state.insert(overlay);
    return LoadingScreenController(
      closeScreen: (){
        textStream.close();
        overlay.remove();
        return true;
      },
      updateScreen: (text){
        textStream.sink.add(text);
        return true;
      }
    );
  }
}